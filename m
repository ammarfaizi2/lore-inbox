Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTEGHP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTEGHP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:15:27 -0400
Received: from kettenhemdhuehner.de ([217.160.131.79]:42138 "EHLO
	p15104972.pureserver.info") by vger.kernel.org with ESMTP
	id S262932AbTEGHPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:15:24 -0400
Date: Wed, 7 May 2003 09:27:51 +0200
From: Kristian Koehntopp <kris@koehntopp.de>
To: linux-kernel@vger.kernel.org
Cc: kris@koehntopp.de
Subject: ACPI and Dell 8100
Message-ID: <20030507072751.GA29914@p15104972.pureserver.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dell Inspiron 8100, BIOS A14. Suse Linux 8.2, Kernel 2.4.20 with
Suse Patches - ACPI does no longer work properly. Suse Linux 8.1
with Kernel 2.4.19 with Suse Patches worked properly.
NVidia Drivers loaded at later point in time.

At boot, I get the following messages when inserting the acpi modules:

lp0: using parport0 (polling).
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.

Consequently,

kk@kris:/proc/acpi/battery/BAT1> for i in *
> do
> echo "*** $i ***"
> cat $i
> done
*** alarm ***
alarm:                   unsupported
*** info ***
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:
serial number:
battery type:
OEM info:
*** state ***
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      0 mAh
present voltage:         0 mV

kris:~ # lsmod
Module                  Size  Used by    Tainted: P
appletalk              19940   1  (autoclean)
ax25                   39028   1  (autoclean)
ipx                    16132   1  (autoclean)
snd-pcm-oss            45888   0  (autoclean)
snd-mixer-oss          13560   1  (autoclean) [snd-pcm-oss]
usbserial              18460   0  (autoclean) (unused)
parport_pc             25800   1  (autoclean)
lp                      6240   0  (autoclean)
parport                22440   1  (autoclean) [parport_pc lp]
videodev                5600   0  (autoclean)
agpgart                35520   3  (autoclean)
nvidia               1547456  11  (autoclean)
isa-pnp                29672   0  (unused)
ipv6                  134388  -1  (autoclean)
autofs4                 8116   1  (autoclean)
snd-maestro3           13412   1
snd-pcm                62912   0  [snd-pcm-oss snd-maestro3]
snd-timer              11904   0  [snd-pcm]
snd-ac97-codec         31152   0  [snd-maestro3]
snd                    35940   0  [snd-pcm-oss snd-mixer-oss snd-maestro3 snd-pcm snd-timer snd-ac97-codec]
soundcore               3396   0  [snd]
ds                      6604   2
yenta_socket            9760   2
pcmcia_core            41824   0  [ds yenta_socket]
keybdev                 1996   0  (unused)
hid                    18308   0  (unused)
mousedev                4148   1
joydev                  5632   0  (unused)
evdev                   4032   0  (unused)
input                   3104   0  [keybdev hid mousedev joydev evdev]
usb-uhci               22096   0  (unused)
usbcore                57836   1  [usbserial hid usb-uhci]
raw1394                14516   0  (unused)
ohci1394               16180   0  (unused)
ieee1394               32880   0  [raw1394 ohci1394]
af_packet              12392   0  (autoclean)
e100                   49992   1
thermal                 6020   0  (unused)
processor               8184   0  [thermal]
fan                     1472   0  (unused)
button                  2380   0  (unused)
battery                 5600   0  (unused)
ac                      1664   0  (unused)
ide-cd                 29404   0  (autoclean)
cdrom                  28192   0  (autoclean) [ide-cd]
lvm-mod                65412   0  (autoclean)
reiserfs              200532   2
kris:~ # uname -a
Linux kris 2.4.20-4GB #1 Mon Mar 17 17:54:44 UTC 2003 i686 unknown unknown GNU/Linux

Any suggestions?

Kristian
