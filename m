Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJHLTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 07:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTJHLTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 07:19:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:48786 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261351AbTJHLTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 07:19:01 -0400
Date: Wed, 8 Oct 2003 13:19:00 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: devel@XFree86.Org, xfree86@XFree86.Org, dri-devel@lists.sourceforge.net,
       dri-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: drm 'lockup' with i845G onboard graphics....
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <20112.1065611940@www60.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I switch from an X session to the (text mode) VGA console, the kernel
logs these messages and X gets killed:

[drm:i830_wait_ring] *ERROR* space: 131048 wanted 131064
[drm:i830_wait_ring] *ERROR* lockup

The mode I'm running in is 1600 x 1200 x 16bpp, and the Intel 845G Extreme
Graphics core is allocated 8MB of graphics memory.

Please CC me for more information.

OS is RedHat Linux 9 with XFree86-4.3.0-2.

---

# lspci -vxxx
(vga controller)
00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G]
Chipset Integrated Graphics Device (rev 01) (prog-if 00 [VGA])        Subsystem:
Compaq Computer Corporation: Unknown device 00b8
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Memory at fc400000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
00: 86 80 62 25 07 00 90 00 01 00 00 03 00 00 00 00
10: 08 00 00 f0 00 00 40 fc 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e b8 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 2a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

(memory controller)
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
(rev 01)
        Flags: bus master, fast devsel, latency 0
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0105]
00: 86 80 60 25 06 01 90 20 01 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
40: 3c 03 00 00 41 20 10 20 04 01 00 00 1b 08 10 00
50: 00 00 44 00 00 00 00 01 1a 16 12 00 35 2c 3f 30
60: 08 08 08 08 00 00 00 00 00 00 00 00 00 00 00 00
70: 02 00 00 00 00 00 00 00 05 84 41 2b 71 c1 00 20
80: 5d 00 af 00 ad 00 00 00 01 00 00 00 00 00 00 00
90: 10 11 11 11 11 33 33 00 45 04 00 00 00 0a b8 00
a0: 02 00 20 00 17 02 00 1f 00 00 00 00 00 00 00 00
b0: 00 00 00 00 30 00 00 00 00 00 00 00 20 10 00 00
c0: 44 40 30 11 00 00 0c 0a 00 00 00 00 00 00 00 00
d0: 02 28 04 0e 0b 0d 00 10 00 00 11 b3 00 00 01 00
e0: 00 00 00 00 09 00 05 01 00 00 00 00 00 00 00 00
f0: 38 0e 00 00 74 f8 00 00 40 0f 00 00 04 00 00 00
(snip)

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

