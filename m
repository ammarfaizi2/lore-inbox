Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262819AbSJHNfM>; Tue, 8 Oct 2002 09:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbSJHNfM>; Tue, 8 Oct 2002 09:35:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34708 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262819AbSJHNex>;
	Tue, 8 Oct 2002 09:34:53 -0400
Date: Tue, 8 Oct 2002 15:40:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Better naming of HID devices [3/23]
Message-ID: <20021008154029.B18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008153926.A18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:39:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.32, 2002-09-24 13:56:28+02:00, bhards@bigpond.net.au
  Better naming for USB input devices that omit the manufacturer name.


 hid-core.c |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Oct  8 15:27:25 2002
+++ b/drivers/usb/input/hid-core.c	Tue Oct  8 15:27:25 2002
@@ -1469,6 +1469,8 @@
 		strcat(hid->name, buf);
 		if (usb_string(dev, dev->descriptor.iProduct, buf, 64) > 0)
 			snprintf(hid->name, 64, "%s %s", hid->name, buf);
+	} else if (usb_string(dev, dev->descriptor.iProduct, buf, 128) > 0) {
+			snprintf(hid->name, 128, "%s", buf);
 	} else
 		snprintf(hid->name, 128, "%04x:%04x", dev->descriptor.idVendor, dev->descriptor.idProduct);
 

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.32
## Wrapped with gzip_uu ##


begin 664 bkpatch18415
M'XL(`#W=HCT``[6476_3,!2&K^-?<;0)T6EM8CM?;5"KL8$`@435:M?(<9PF
MM(DKVRDJA/^.DXX-&'1B@B07MN/S^CW'CWT*UUJHQ-G)CT;P`IW":ZE-XNA&
M"Y=_MOV%E+;O%;(2WLTL+UU[9;UM#++_Y\SP`G9"Z<0AKG\[8O9;D3B+EZ^N
MWSU?(#2=PE7!ZI58"@/3*3)2[=@FTQ?,%!M9NT:Q6E?",)?+JKV=VE*,J7U#
M$OLXC%H2X2!N.<D(80$1&:;!.`K0C;&+&]N_QD^H;T4F8=!B,IY$Z`40-XQ]
MU_JE@*F')QX-@/A)&"5T?(YI@C&D!5/67UJNMK+.W%H8ES5P3F"$T27\6_]7
MB,.E,$8HJ%E5UBO(I8+KY27T=89,[$HN-)B"&9!5:6Q+0,7J)F?<-.H0)UST
M%F@8$32_*S8:_>6#$&88S1[(,%-EM^=>HU.O*#.7_Y!I@$G<!H$=:+.8D#C/
MXS3.)HQ%X>^K^I-:GW&G.>)2B>_"$QH0$D;4;S$.*>Z!.A;U,&./S`"ME%A=
MK)5DQ3V9/U@G$25^9]TR%Y.>/G]\CSO_.'?T?W&WM"<;UF*?RFY=R&3]U$#!
M=@+8?<*&H$V3YQVAPJ:]-X5M6I&R-A*V2F8--P<4NXNEYW4(90YLQ\H-2S<]
MHMW^O8>1^M1_EKCYT:U\!,%O2!`3H,CY"F)C?5@'`RO]01ME_0[L<1IV9VHT
MRX3FJMS:JKKE_&!_"&F3#X'0\1G,`)_!%^0XCJZW-M3D@\[7[%`*.V4()T_T
>21]R]NSN.N2%X&O=5-.0<7OCX`!]`];JN_II!0``
`
end
