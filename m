Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSLWBt0>; Sun, 22 Dec 2002 20:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSLWBt0>; Sun, 22 Dec 2002 20:49:26 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:39813 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S265568AbSLWBtZ>;
	Sun, 22 Dec 2002 20:49:25 -0500
Date: Mon, 23 Dec 2002 02:57:23 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, joe user <joe_user35@hotmail.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH] /proc/net/tcp + ipv6 hang
Message-ID: <20021223015723.GA17439@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18QHqN-0004bp-00*8qNXLywSUiA* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes an infinite loop when reading /proc/net/tcp and having
daemons listening on ipv6.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.913, 2002-12-23 02:49:19+01:00, andersg@0x63.nu
  Fix infinite loop when reading /proc/net/tcp with ipv6-sockets.


 tcp_ipv4.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	Mon Dec 23 02:55:45 2002
+++ b/net/ipv4/tcp_ipv4.c	Mon Dec 23 02:55:45 2002
@@ -2236,6 +2236,7 @@
 			goto get_req;
 		}
 		read_unlock_bh(&tp->syn_wait_lock);
+		sk = sk->next;
 	}
 	if (++st->bucket < TCP_LHTABLE_SIZE) {
 		sk = tcp_listening_hash[st->bucket];

===================================================================


This BitKeeper patch contains the following changesets:
1.913
## Wrapped with gzip_uu ##


begin 664 bkpatch1524
M'XL(`"%M!CX``]54WVO;,!!^MOZ*@SZ6V#I+=FP/EVS=3S98R.CS4.1+;)Q(
MP5:3#/S'3\E"6]*6LK*7G?1PTIU.G^[[T`7<]-05@3(5=?V27<!GV[LBX/M4
MA.;6KV?6^G54VS5%IZRHI<[0*IJWT7QE=\QG3973-6Q]M`@P%'<[[M>&BF#V
MX=/-M[<SQLH2KFMEEO2#')0E<[;;JE753Y2K5]:$KE.F7Y-3H;;KX2YUB#F/
M_4AP+'B2#IAR.1XT5HA*(E4\EEDJV0G>Y`3^[#S&WD0L,!D2@7G"W@.&.0K@
M<81Q%!^<0N8%YI<<"\[AK!Q<(HPX>P?_%O0UT_"QV4-C%HUI','*V@WL:C+0
MD:H:LX1HTUD=&7*1TS[4N!J:S38=]5:WY/J0?87$%Y-L>M]=-OI+8XPKSJY>
M>-T!A+];'I#\/#BA?OC./,D&*64Z'GRGY\FBRN8YZ92+Q7DWGZWD:1(<I2=F
M2)&/\2B:)Y)?EL^KL3*EUS31UI!VS?98+)QWSR/&6!X0QWQ(\BS%H[!$]DA7
MXC_4U1\*OL.HVQVGU\GT*39>(;<OGN@,D`5!WT()?3NZ,K1W;^Z_$UV3;OO;
1=4D9*2FJ!?L-758XOZ\$````
`
end
