Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRGCV6x>; Tue, 3 Jul 2001 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266035AbRGCV6d>; Tue, 3 Jul 2001 17:58:33 -0400
Received: from archive.osdlab.org ([65.201.151.11]:41450 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266034AbRGCV6b>;
	Tue, 3 Jul 2001 17:58:31 -0400
Message-ID: <3B424019.552D0BCE@osdlab.org>
Date: Tue, 03 Jul 2001 14:58:50 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: colin_bayer@compnerd.net, linux-kernel@vger.kernel.org
Subject: Re: Sticky IO-APIC problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Bayer scribed:
| I have a Pentium III 933/133 (Coppermine, stepping 6) in an
Intel-manufactured
| i810 motherboard (hey, I

What mobo (model/name) is it?
Can you give us the output from "lspci -vv"?

| know it's a lame chipset, but it was on sale). On boot, the kernel
(version
| 2.4.6-pre8) identifies and maps the
| IO-APIC onboard, but does not assign any IRQs to it. 
| 
| The relevant boot log snippet follows. 
| 
| [root@fortytwo i386]# cat /var/log/dmesg 
|  ... 
|  ... 
| mapped APIC to ffffe000 (0121c000) 

This shows that Linux mapped the APIC (part of the processor).
It says nothing about mapping any IO APICs (unless you deleted
that part :).

So, how does one know if a (UP) system has an IO APIC and that
Linux can be configured to use the UP IO APIC code?...

(That's a serious question: does an IO APIC show up in lspci output?)

And why do you think that this system has an IO APIC?
Is it documented to have one?
[just digging for clues]

| Kernel command line: auto BOOT_IMAGE=linux-test ro root=307
| BOOT_FILE=/boot/vmlinuz-2.4.6-pre8
| devfs=mount pirq=9,4 
| PIRQ redirection, working around broken MP-BIOS. 
| ... PIRQ0 -> IRQ 9 
| ... PIRQ1 -> IRQ 4 
|  ... 
|  ... 
| 
| And /proc/interrupts: 
| [root@fortytwo i386]# cat /proc/interrupts 
|            CPU0 
|   0: 79409 XT-PIC timer 
|   1: 5911 XT-PIC keyboard 
|   2: 0 XT-PIC cascade 
|   4: 990 XT-PIC es1371 
|   8: 1 XT-PIC rtc 
|   9: 26402 XT-PIC usb-uhci, serial 
|  11: 16473 XT-PIC i810@PCI:0:1:0 
|  14: 5152 XT-PIC ide0 
|  15: 47 XT-PIC ide1 
| NMI: 0 
| ERR: 0 
| MIS: 0 
| [root@fortytwo i386]# 
| 
| This problem also occurs when booting without the pirq switch. I've
configured
| everything the way it's
| mentioned in Documentation/i386/IO-APIC.txt, but it doesn't help.
Anyway, thx in
| advance for the help. 

~Randy
