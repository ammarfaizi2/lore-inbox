Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274642AbRJAHBZ>; Mon, 1 Oct 2001 03:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274656AbRJAHBP>; Mon, 1 Oct 2001 03:01:15 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:47112 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S274642AbRJAHA7>; Mon, 1 Oct 2001 03:00:59 -0400
Subject: 2.4.11-pre1 -- depmod: Unexpected value (20) in
	drivers/ieee1394/sbp2.o for ieee1394_device_size
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 30 Sep 2001 23:53:22 -0700
Message-Id: <1001919223.1247.13.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the error:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.11-pre1; fi
depmod: Unexpected value (20) in '/lib/modules/2.4.11-pre1/kernel/drivers/ieee1394/sbp2.o' for ieee1394_device_size
	It is likely that the kernel structure has changed, if so then
	you probably need a new version of modutils to handle this kernel.
	Check linux/Documentation/Changes.
make: *** [_modinst_post] Error 255

ver_linux reports:

Linux stomata.megapathdsl.net 2.4.11-pre1 #1 Sun Sep 30 22:03:05 PDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.9
e2fsprogs              1.25
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         emu10k1 sound ac97_codec soundcore serial_cs af_packet 3c59x keybdev hid input usb-ohci nls_iso8859-1 nls_cp850

My .config file includes:

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_VERBOSEDEBUG=y


