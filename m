Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUDJUFp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUDJUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:05:45 -0400
Received: from web40501.mail.yahoo.com ([66.218.78.118]:4241 "HELO
	web40501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261803AbUDJUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:05:44 -0400
Message-ID: <20040410200543.62548.qmail@web40501.mail.yahoo.com>
Date: Sat, 10 Apr 2004 13:05:43 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Updated Ross Dickson C1Halt patch for 2.6.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to say your updated C1 patch works for me.

A little history.
I got an ASUS A7N8X-X motherboard with a XP 3200+ CPU. For 3 days
the system worked fine with vanilla Linux 2.6.3 (no apic patch).
My workload consisted of web surfing and hacking. I built Xfree86
from source. No problems. Then I added an Adaptec 2940UW and a DAT
tape unit for backups. About 10-15 minutes into a backup, the system
would freeze. The freeze was 100% reproducible: I tried 6-7 times. 
I then upgraded to 2.6.5, applied your patch, and rebooted. I then
tried to do a backup: FREEZE!! What tha.....??? Ah, forgot to supply
idle=C1halt to the kernel. Supplied it, and did a backup: No freeze!!

Long story short, been running for two days, doing backups, etc. No freezes.

Here's my /proc/interrupts:

           CPU0       
  0:   69486179          XT-PIC  timer
  1:      12748    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     493447    IO-APIC-edge  i8042
 14:     998896    IO-APIC-edge  ide0
 15:         22    IO-APIC-edge  ide1
 16:     785983   IO-APIC-level  aic7xxx, ehci_hcd
 19:   26985093   IO-APIC-level  eth0, radeon@PCI:3:0:0
NMI:          0 
LOC:   69486209 
ERR:          0
MIS:          6

Thanks for your efforts. 


-Alex

=====
I code, therefore I am

__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
