Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCJQXX>; Mon, 10 Mar 2003 11:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbTCJQXX>; Mon, 10 Mar 2003 11:23:23 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:26826 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id <S261346AbTCJQXV>;
	Mon, 10 Mar 2003 11:23:21 -0500
Date: Mon, 10 Mar 2003 09:34:01 -0700
From: Troy Heber <troyh@fc.hp.com>
To: linux-kernel@vger.kernel.org
Subject: BUG in 2.4.20?
Message-ID: <20030310163401.GA21175@troypc.fc.hp.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have found a bug in 2.4.20. I am running on a dual processor
PIII with a ServerWorks (RCC) chipset that has 3 32-bit 33MHz 5V PCI slots
and two 64-bit 66 MHz PIC slots. Starting with 2.4.20 my Adaptec 39160 is no
longer detected (it's in a 64-bit slot). I have tried both slots and every
possible kernel config I can think of, including booting with  pci=noacpi.
The card does not show up with a lspci or cat /proc/pci. If I compile the
AIC7xxx driver as a module and try to load it, I get a message that says that
I do not have the device installed. 

2.4.19 and below are fine. This patch from the rc3 -> rc4 changelog just
caught my eye.  

 	Fixup pci_alloc_consistent with 64bit DMA masks on i386

I will try 2.4.20-rc3 tonight to see if I can nail it down to specific
version.  However, before I put to much effort into this, is this a known
issue? I searched the archives and haven't seen anything related yet. 

Thanks,

Troy
