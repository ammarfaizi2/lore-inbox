Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132067AbRADAQx>; Wed, 3 Jan 2001 19:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131802AbRADAQd>; Wed, 3 Jan 2001 19:16:33 -0500
Received: from 209.102.21.2 ([209.102.21.2]:59661 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129324AbRADAQ3>;
	Wed, 3 Jan 2001 19:16:29 -0500
Message-ID: <3A53905B.FA785099@goingware.com>
Date: Wed, 03 Jan 2001 20:49:31 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to power off with ACPI/APM?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ASUS P3V4X motherboard with an ACPI BIOS.  This is a desktop machine,
and while APM is normally of concern for laptops, it seems to me from what I
read in the kernel config help that I should be able to make the machine power
itself off.

If I have ACPI enabled but not APM, when I do "shutdown -h now", I see these
messages at the end:

Power Down
ACPI: S5 failed

and the machine stays powered on.

Looking back in the ACPI kernel config help, it says you can use ACPI if you
also have APM enabled, which I didn't do at first.   I enabled it, and the "S5
failed" message goes away at the end, but my machine still doesn't power down. 
I notice in the kernel messages at boot time that ACPI says something like "APM
already enabled, exiting".

This isn't that big a deal to me personally (I can always hit the power switch)
but if it's a kernel bug I want to help track it down.  Alternatively, if it's
something I'm doing wrong I can help clarify and document the procedure for
making this work.

I'm using 2.4-prerelease-ac5, which generally seems to be working pretty good
for me.  Other exciting details of this machine are that it has an adaptec 28160
Ultra160 SCSI host bus adapter that works fine with the disk.  I'll try burning
a CD with it shortly.  It's got a Pentium III 667 with 128MB of ram running at
133 MHz, a 3C905B 10/100 ethernet card and a ATI Rage Millenium with 32 MB of
video ram.  I've got XFree86 4.0.1 on it with DRI working (and DRM and AGP
enabled in the kernel) with a VIA chipset on the motherboard - I generally had
little luck ever getting accellerated drivers to work under XFree86 3.x, but
things went much better with 4.  I get on the internet with the ppp_async module
via a 56k external modem.

Mike 
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
