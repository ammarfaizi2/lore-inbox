Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSJKKi3>; Fri, 11 Oct 2002 06:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSJKKi3>; Fri, 11 Oct 2002 06:38:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:5252 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262384AbSJKKi2>;
	Fri, 11 Oct 2002 06:38:28 -0400
Date: Fri, 11 Oct 2002 12:44:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - HID - fix find_next_zero usage [1/5]
Message-ID: <20021011124406.A1677@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.733.3.1, 2002-10-10 01:22:17-03:00, acme@dhcp197.conectiva
  o hid-input: fix find_next_zero_bit usage
  
  It was swapping the parameters, using the bitfield size for the
  offset and the offset for the bitfield size. With this the mouse
  buttons in my wireless USB keyboard finally works 8) 2.4 has the
  same problem.


 hid-input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Fri Oct 11 12:42:52 2002
+++ b/drivers/usb/input/hid-input.c	Fri Oct 11 12:42:52 2002
@@ -348,7 +348,7 @@
 	set_bit(usage->type, input->evbit);
 
 	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
-		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
+		usage->code = find_next_zero_bit(bit, usage->code, max + 1);
 	}
 
 	if (usage->code > max) return;

===================================================================

This BitKeeper patch contains the following changesets:
1.733.3.1
## Wrapped with gzip_uu ##


begin 664 bkpatch1632
M'XL(`"RKICT``^U56V^;,!1^CG_%D?JRJ@W8AD!@2I6UG;9NDU:UJO88&6R"
M%\`(FZ2I^/%S:):N6U9UT_HVL(6.S\7G\GWB`&ZT:.+!4GTU(LW1`;Q7VL0#
MW6KAI'=6OE+*RFZN2N%NK=QDX<JJ;@VR^DMFTAR6HM'Q@#C>[L2L:Q$/KMZ^
MN_GTY@JAR03.<E;-Q;4P,)D@HYHE*[B>,I,7JG),PRI="L.<5)7=SK2C&%/[
MCDCHX5'0D0#[89<23@CSB>"8^N/`1^=L*?GL@\@RT:RGC+/:YKDG$L$XHA3[
M'NY(%'@4G0-Q0L]S/(<`IB[!=@$F,:4Q"8?8BS$&EI9BRO.T)E%H8U8B-7+)
MX(C`$*-3^+>5G*$4%.22#_L.QY#)6[LK/JO$K9G=B4;-$FF@U6PNK*U=%P96
M3(->L;J6U1Q,+J!F#;,YV*D<6]/OI]8QDZ+@H.6=@$PUF]/-A5FF[5A8Q7NS
MK;C5/_9RX(LT=KJYU+VR5!8I-D32&J,J#;*"<@TKV8A":`TWUZ>P$.M$L89O
MRF!%8;6J66@8'P)U?,B9WF:A;<90-RHI1.F@CT`BCQ)T^8`;-/S#!R',,#JQ
MW;"(W#\?WL@-=MU6)^ZNZTZZFQ;%9.R1CHZLT$4^SP(^#CPQ#KV`>[^!QJ.@
M?<!?0A-LH>C;&\*.1GX4]`1YTFU#FI>J`VV)/34K6<AY;IPV75GZ/Z,0'-(1
M(:.`^MM"-HPB/Y$)Q_099"+_R?1R9+H?SF<8-JM^67)</@VXOV#;N3<B0-#%
M_6<PZ/LZ/$D5%S#9T_A7=A_##U;'4+);.`)R^/KAWY+F(EWHMIQP/,:92"+T
)#4&:=1RV!@``
`
end
