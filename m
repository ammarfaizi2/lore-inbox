Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAPSIw>; Tue, 16 Jan 2001 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAPSIn>; Tue, 16 Jan 2001 13:08:43 -0500
Received: from cmr1.ash.ops.us.uu.net ([198.5.241.39]:27017 "EHLO
	cmr1.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S129562AbRAPSI1>; Tue, 16 Jan 2001 13:08:27 -0500
Message-ID: <3A648EC3.4B5D7763@uu.net>
Date: Tue, 16 Jan 2001 13:11:15 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APM, ACPI, WOL, Oh My!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something special that linux vendors do to make their machines
power off when they are shutdown?  I've used both redhat and mandrake
supplied 2.4.x SMP kernels, and all of them manage to turn off the
machine when I shutdown.  I realize that apm is not supported in smp
mode, but the have the option apm=poweroff in my lilo.conf and with the
vendor supplied kernels it always works fine.  However, whenever I build
by own SMP kernel, I cannot get it to power off.  I have tried just
about every combination of apm options, but to no avail.  I've been
building apm into the kernel rather than as a module.  I also tried with
both apm and acpi, since some of the vendor kernels have had both
enabled on them, but still to no avail.

WOL (Wake on LAN) also ties into this.  I recently added a WOL ethernet
card so I could wake my PC remotely.  It works fine, but there are some
strange caveats...

If I shutdown in linux using a vender kernel with apm that powers off
the machine, it powers off fine and stays off until I hit the power
button or I send a wake up packet.  If I shutdown and power off using
win98, or with the power button, the machine goes off, but will then
preceed to reboot with in 3-4 minutes.  This is completely repeatable. 
Turning it off manually during the reboot will not stop this.  If I turn
it off manually after it turns itself on, it will continue to try and
reboot itself every few minutes.  they only solution is to let linux
boot and perform a shutdown and power off.  then it stays off. 

AFAIK, WOL is software independant.  The only thing I can figure it that
it is somehow tied into apm or acpi and some state that the machine is
left in after a shutdown.

Sorry if this is somewhat off topic.

Thanks,

Alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
