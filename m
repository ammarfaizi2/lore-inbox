Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbTDAPhS>; Tue, 1 Apr 2003 10:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTDAPhS>; Tue, 1 Apr 2003 10:37:18 -0500
Received: from [198.107.178.126] ([198.107.178.126]:38163 "EHLO
	fairfax-66.promisemark.com") by vger.kernel.org with ESMTP
	id <S262597AbTDAPhR>; Tue, 1 Apr 2003 10:37:17 -0500
Date: Tue, 1 Apr 2003 10:48:14 -0500
To: "Grover, Andrew" <andrew.grover@intel.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.66] Enormous interrupt load with ACPI
Message-ID: <20030401154808.GA3899@bittwiddlers.com>
References: <F760B14C9561B941B89469F59BA3A84725A239@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A239@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1049644100.21de6f@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll have to check for the polarity and trigger but I have essentially the
same problem.  I've just been running without acpi on my laptop for months
since it won't work with it.  In my case, though, I do have the sound card
on the same interrupt

{25}: cat /proc/interrupts 
           CPU0       
  0:   11772951          XT-PIC  timer
  1:         28          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:         51          XT-PIC  VIA8233
 10:        263          XT-PIC  uhci-hcd, uhci-hcd, eth0
 11:     506669          XT-PIC  ENE Technology Inc CB1410 Cardbus Contr, eth1
 12:         35          XT-PIC  i8042
 14:      89289          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0


And my laptop freezes solid when I try to even run with acpi on.  I think
I even fixed my acpi dsdt table but I haven't been able to check due to this
other problem




> polarity 1 = active high
> trigger 3 = level
> 
> Can you look at /proc/interrupts and tell me if irq 9 is shared with
> anyone else, especially PCI devices?

-- 
  Matthew Harrell                           Microwaves frizz your heir...
  Bit Twiddlers, Inc.
  mharrell@bittwiddlers.com     
