Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263328AbSJHN5T>; Tue, 8 Oct 2002 09:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJHN43>; Tue, 8 Oct 2002 09:56:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:1941 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263283AbSJHN4P>;
	Tue, 8 Oct 2002 09:56:15 -0400
Date: Tue, 8 Oct 2002 16:01:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Ignore mouse sync bit [21/23]
Message-ID: <20021008160148.T18546@ucw.cz>
References: <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz> <20021008155915.Q18546@ucw.cz> <20021008160001.R18546@ucw.cz> <20021008160100.S18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008160100.S18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 04:01:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.55, 2002-10-07 16:22:25+02:00, vojtech@suse.cz
  psmouse.c: ignore the sync bit to make slightly non-conforming devices
  work.


 psmouse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:17 2002
+++ b/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:17 2002
@@ -201,7 +201,7 @@
 	psmouse->packet[psmouse->pktcnt++] = data;
 
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
-		if ((psmouse->packet[0] & 0x08) == 0x08) psmouse_process_packet(psmouse);
+		psmouse_process_packet(psmouse);
 		psmouse->pktcnt = 0;
 		return;
 	}

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.55
## Wrapped with gzip_uu ##


begin 664 bkpatch17893
M'XL(`+W<HCT``[64;6O;,!"`/T>_XJ`?ME%BG^37>&1T:T=7-EC(Z.<BRVKL
MQ9:"I21D^,=/<4P*Z0C=6&UCH]/I7I_S!=P;V6:CC?YII2C)!7S1QF8CLS;2
M$[_<>JZU6_NE;J0_:/GYTJ_4:FV)VY]Q*TK8R-9D(^H%1XG=K60VFG^^O?_V
M<4[(=`K7)5<+^4-:F$Z)U>V&UX6YXK:LM?)LRY5II.6>T$UW5.T8(G-W1),`
MH[BC,89))VA!*0^I+)"%:1R2(;"K(>R3\Q0QH4&04MJQ(*81N0'J14G@N7<$
MR'R*/B9`XXRQC$67R#)$.+$)EQ3&2#[!_XW\F@A8F4;W3C*H%DJW$FPIP>R4
M@+RRSB$T?.D$=;4H;;T#I=58:/6HVZ92"RCDIA+2.$-;W2X]\A7V64[([*GB
M9/R7%R'(D7PX%L%NJ]Z[MQ;;?8&+MMJW_("!WX?O'],XI)Y@0`-,0]9A&F/<
MY4F>1VD1I(\RC)B4IP5^@<V^D2%CS#5R,HDF/59GC^U1>\4<GH'WLAPP#4**
M7<`FR0%&^AQ#>@9#^BH8WOV!O3$8-_C@C(MESNO:0*'5&PO&3;';YJK8ZZM!
M>N2O;\YW&+?;_G$\S<[WZ1\`O6$8`B5WA\]H--AZ6+7:38-Y6+F0I7T[B-^]
9?_I9B5**I5DW4YXCQ@7GY#>S4$[]!P4`````
`
end
