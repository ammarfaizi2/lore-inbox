Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbSKPLG7>; Sat, 16 Nov 2002 06:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSKPLG7>; Sat, 16 Nov 2002 06:06:59 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:39944 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267264AbSKPLGz>; Sat, 16 Nov 2002 06:06:55 -0500
Date: Sat, 16 Nov 2002 09:13:44 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tr: make CONFIG_TR depend on CONFIG_LLC=y
Message-ID: <20021116111344.GD24641@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	It was recently synced with Linus, but I saw with bk cmdlog
that you also pulled the same tree, so...

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.811, 2002-11-16 08:57:33-02:00, acme@conectiva.com.br
  o tr: make CONFIG_TR depend on CONFIG_LLC=y
  
  Also update help, clarifying that LLC is needed for Token Ring
  Support.
  
  Fixes one of the make allmodconfig undefined symbols report on lkml.


 drivers/net/tokenring/Kconfig |    4 ++--
 net/Kconfig                   |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)


diff -Nru a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	Sat Nov 16 09:10:41 2002
+++ b/drivers/net/tokenring/Kconfig	Sat Nov 16 09:10:41 2002
@@ -2,13 +2,13 @@
 # Token Ring driver configuration
 #
 
-menu "Token Ring devices"
+menu "Token Ring devices (depends on LLC=y)"
 	depends on NETDEVICES
 
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
 	bool "Token Ring driver support"
-	depends on PCI || ISA || MCA
+	depends on (PCI || ISA || MCA) && LLC=y
 	help
 	  Token Ring is IBM's way of communication on a local network; the
 	  rest of the world uses Ethernet. To participate on a Token Ring
diff -Nru a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	Sat Nov 16 09:10:41 2002
+++ b/net/Kconfig	Sat Nov 16 09:10:41 2002
@@ -266,14 +266,14 @@
 	tristate "802.1Q VLAN Support"
 
 config LLC
-	tristate "ANSI/IEEE 802.2 Data link layer protocol (IPX, Appletalk)"
+	tristate "ANSI/IEEE 802.2 - aka LLC (IPX, Appletalk, Token Ring)"
 	help
-	  This is a Logical Link Layer protocol used for Appletalk, IPX and in
-	  the future by NetBEUI and by the linux-sna project. It originally
-	  came from Procom Inc. that released the code for 2.0.36 and was
-	  ported to 2.{4,5}. Select this if you want to have support for
-	  those protocols or if you want to have the sockets interface for
-	  LLC.
+	  This is a Logical Link Layer protocol used for Appletalk, IPX,
+	  Token Ring devices, the linux-sna.org project and in the future by
+	  NetBEUI. It originally came from Procom Inc. that released the code
+	  for 2.0.36 and was heavily modified to work with 2.{4,5}.
+	  Select this if you want to have support for those protocols or if
+	  you want to have the sockets interface for LLC.
 	  
 
 config LLC_UI

===================================================================


This BitKeeper patch contains the following changesets:
1.811
## Wrapped with gzip_uu ##


begin 664 bkpatch18980
M'XL(`+$GUCT``^U6;6_;-A#^;/V*0PH4*1;+)/5J`Q[B.&EK)$N-O``#AF%@
M)-K2+)$"13GUIO[W'N4UR9(T2XIBGVH+DB'>/;Q[[GD(OX++6NA1CR>E<%[!
M>U6;42]14B0F7W,W4:5[I7'A3"E<&&2J%(.#XX$4IL_<P,&5.3=)!FNAZU&/
MNM[-&[.IQ*AW=O3N\F1RYCCC,4PS+I?B7!@8CQVC])H7:;W/358HZ1K-95T*
MT^W9WH2VC!"&WX!&'@G"EH;$C]J$II1RGXJ4,#\.?6>=:[5?(I1;U8TKTN8>
M`J4TH$/J,]J&!*&<0Z!N3"D0-J!T0$,@\2B(1I[7)VQ$"%@^]N_S`#\QZ!/G
M`+YO\5,G`05&CZ#D*P'3#Z=O9^_^N#B#5%1"IJ#DEW<G)]/Q!J/QFA2U@J9*
MN1&0B:+:@Z3@.E]L<KD$DW$#&`QY#5*(5*2P4!HNU$I(.,,(!#AOJDIIXV[A
MWN8?18T["5`+3!?;4GA1E"I%&A;Y$AJ9BD4N$:O>E%>JJ$$+BV#K*U9EX3K'
M$,1A$#OSVU$[_1=^'(=PXOP,?^55)8K](I?-QWX9QBM7Z>5O7XC_O4UU;C5G
ME3@PMB^-;0V.M[5N9TX\0GR/>5[KL8A%K>_'<>(M8LHX"?'GXT-^#C*E(26!
M'T1MP*)A\(QR+=BCQ<58W#`>MI2%D4"!,,$\.DS]KQ3W`.>V%!9X7MP9[<D.
MK/G^!W*_YQY^&Y#0"SK3LG];UD?7_J=EV0_+/F'93L$?H*^ONPLM.']:0=_@
MZ<,`J#.SMU+(!G9NVT+&UGF"C>QNJ;,=04?:FQWG$$]HS.ONO3OKN_/I#-H6
M9N<3^_AE.GD#KU]OTSH'W+')<_3^8G<Z5QSGD`JW3K)F(_1^Q66J-'>OQ",6
M)1$9TB`8MHSY$>UD'+Q4QA'THQ\R_KJ,MZ??/1G?&<6WB):%0RN_[:-G=%X;
MV_3.Y/1\-I@='1U!3!B>2'W@*]YUO3N;_[H'DZHJ<"3%:N].XU;.+*(0(F`4
MXJ,'<)$A37AALEKF"2_@))<K..$H*:BT,BI1!33U/RS>P;7[=`@/C+37D;B5
M>BVY5;J%^A/U!"A2R&47L&A,HP5<;2S*J3`'1Y<S%V;(J<Z7N43^-Y#P$@.U
M*F&NL9(29C)QMR/6HA#<UF6Q$I4*"V-K9"YQO;#;Z9K7*!"^SA$*AYDO<ANO
MX%KI%5SG)L/@O_V]X)-KD\\1$4LT'24+V*@&`:2Q"1E?"ZBWJNDV,9FJQ0U!
MJ!Z-*1;D098MKU;)2AA$E4;H!4]$AX'C<F__OR:92%9U4XY33M+`H[[S&?FG
&J9,:"P``
`
end
