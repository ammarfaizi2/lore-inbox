Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbVCDW1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVCDW1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVCDWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:22:57 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:31929 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261210AbVCDVCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:02:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=R9QPtBF5Fd/rOAuuhetYXEcevLyQZp1QNfrLFnHZl6ZqxtR0JbxSGV7Ki+f3klSddBNa2XJVUxULehJf0hqNKwnKi3EarQB1WLmOwMgzp8mEE1os89kC/G8pmxvyj6A97TkozOtzddoDp6LKc/sm7gAIMD1j0QifTJylObAQRd8=
Message-ID: <40f323d005030413024d71e3f9@mail.gmail.com>
Date: Fri, 4 Mar 2005 22:02:03 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: New ALPS code in -mm
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050301115432.GA5598@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_661_11007776.1109970123516"
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net>
	 <200502242208.16065.dtor_core@ameritech.net>
	 <20050227075041.GA1722@ucw.cz>
	 <Pine.LNX.4.62.0502281721210.21033@light.int.webcon.net>
	 <422454A5.7070206@blue-labs.org> <20050301115432.GA5598@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_661_11007776.1109970123516
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 1 Mar 2005 12:54:32 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> Can you check with a current -mm kernel whether any of the issues is
> still there? Everything seems to work smoothly with my ALPS.
> 

I have problems with ALPS and 2.6.11-mm1. If I move the pointer with
the touchpad, it activates button modifiers at the same time. (xev
reports a MotionNotify event with state = 0x600 or sometimes 0x200
instead of the expected 0x0).

Moreover the pointer sometimes jump at the bottom right of the screen.

It worked fine with 2.6.11-rc5-mm1.

relevant portion of dmesg:

- with rc5:

Linux version 2.6.11-rc5-mm1 (tonfa@casaverde) (gcc version
3.4.3-20050110 (Gentoo Linux 3.                4.3.20050110,
ssp-3.4.3.20050110-0, pie-8.7.7)) #2 Tue Mar 1 13:33:05 CET 2005
input: AT Translated Set 2 keyboard on isa0060/serio0
ALPS Touchpad (Dualpoint) detected
Enabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

- with .11

Linux version 2.6.11-mm1 (tonfa@casaverde) (gcc version 3.4.3-20050110
(Gentoo Linux 3.4.3.                20050110, ssp-3.4.3.20050110-0,
pie-8.7.7)) #5 Fri Mar 4 16:49:47 CET 2005
input: AT Translated Set 2 keyboard on isa0060/serio0
   Enabling hardware tapping
input: DualPoint Stick on isa0060/serio1
input: AlpsPS/2 ALPS DualPoint TouchPad on isa0060/serio1

I hope it can help.

Benoit

------=_Part_661_11007776.1109970123516
Content-Type: text/x-log; name="lspci.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="lspci.log"

0000:00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Contro=
ller (rev 03)
=09Flags: bus master, fast devsel, latency 0
=09Memory at e0000000 (32-bit, prefetchable)
=09Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Control=
ler (rev 03) (prog-if 00 [Normal decode])
=09Flags: bus master, 66Mhz, fast devsel, latency 32
=09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
=09I/O behind bridge: 0000c000-0000cfff
=09Memory behind bridge: fc000000-fdffffff
=09Prefetchable memory behind bridge: e8000000-efffffff
=09Expansion ROM at 0000c000 [disabled] [size=3D4K]

0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L=
/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
=09Subsystem: Intel Corporation: Unknown device 4541
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09I/O ports at bf80 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L=
/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
=09Subsystem: Intel Corporation: Unknown device 4541
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09I/O ports at bf40 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L=
/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
=09Subsystem: Intel Corporation: Unknown device 4541
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09I/O ports at bf20 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) US=
B2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
=09Subsystem: Dell: Unknown device 011d
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09Memory at f4fffc00 (32-bit, non-prefetchable)
=09Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)=
 (prog-if 00 [Normal decode])
=09Flags: bus master, fast devsel, latency 0
=09Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32
=09I/O behind bridge: 0000d000-0000efff
=09Memory behind bridge: f6000000-fbffffff

0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface =
Bridge (rev 01)
=09Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Control=
ler (rev 01) (prog-if 8a [Master SecP PriP])
=09Subsystem: Intel Corporation: Unknown device 4541
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09I/O ports at <ignored>
=09I/O ports at <ignored>
=09I/O ports at <ignored>
=09I/O ports at <ignored>
=09I/O ports at bfa0 [size=3D16]
=09Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]

0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM=
 (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
=09Subsystem: Dell: Unknown device 011d
=09Flags: bus master, medium devsel, latency 0, IRQ 5
=09I/O ports at b800
=09I/O ports at bc40 [size=3D64]
=09Memory at f4fff800 (32-bit, non-prefetchable) [size=3D512]
=09Memory at f4fff400 (32-bit, non-prefetchable) [size=3D256]
=09Capabilities: <available only to root>

0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) =
AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
=09Subsystem: Conexant: Unknown device 5422
=09Flags: bus master, medium devsel, latency 0, IRQ 11
=09I/O ports at b400
=09I/O ports at b080 [size=3D128]
=09Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf=
 [FireGL 9000] (rev 02) (prog-if 00 [VGA])
=09Subsystem: Dell: Unknown device 011d
=09Flags: bus master, VGA palette snoop, stepping, 66Mhz, medium devsel, la=
tency 32, IRQ 11
=09Memory at e8000000 (32-bit, prefetchable)
=09I/O ports at c000 [size=3D256]
=09Memory at fcff0000 (32-bit, non-prefetchable) [size=3D64K]
=09Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M G=
igabit Ethernet (rev 01)
=09Subsystem: Dell: Unknown device 865d
=09Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
=09Memory at faff0000 (64-bit, non-prefetchable)
=09Capabilities: <available only to root>

0000:02:01.0 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controlle=
r (rev 20)
=09Subsystem: Dell: Unknown device 011d
=09Flags: slow devsel, IRQ 255
=09Memory at 20001000 (32-bit, non-prefetchable) [disabled]
=09Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
=09I/O window 0: 00000000-00000003 [disabled]
=09I/O window 1: 00000000-00000003 [disabled]
=0916-bit legacy interface ports at 0001

0000:02:01.1 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controlle=
r (rev 20)
=09Subsystem: Dell: Unknown device 011d
=09Flags: slow devsel, IRQ 255
=09Memory at 20002000 (32-bit, non-prefetchable) [disabled]
=09Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D176
=09I/O window 0: 00000000-00000003 [disabled]
=09I/O window 1: 00000000-00000003 [disabled]
=0916-bit legacy interface ports at 0001

0000:02:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev=
 05)
=09Subsystem: Intel Corporation: Unknown device 2722
=09Flags: bus master, medium devsel, latency 32, IRQ 11
=09Memory at fafef000 (32-bit, non-prefetchable)
=09Capabilities: <available only to root>


------=_Part_661_11007776.1109970123516
Content-Type: application/gzip; name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
2vBtTt5jIHQ5k9K8LBODY8BS/j+vd26m5ZAAAA==
------=_Part_661_11007776.1109970123516--
