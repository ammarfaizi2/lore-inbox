Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030650AbWF0GPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbWF0GPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWF0GPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:15:08 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:5098
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1030650AbWF0GPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:15:07 -0400
Message-ID: <44A0CCEA.7030309@ed-soft.at>
Date: Tue, 27 Jun 2006 08:15:06 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what is your suggestion to get the working funktionality
from kernel 2.6.16 back ? 2.6.17 have broken it.

Sure, using Apples legacy support for EFI is a method to
boot linux on the Intel Macs, but not the native way. It depends
on how good their legacy emulation is and if they implement it
in future products. They could also decide to drop it.

cu

Edgar (gimli) Hucek 

Linus Torvalds schrieb:
> 
> On Mon, 26 Jun 2006, Edgar Hucek wrote:
>> Fix EFI boot on 32 bit machines with PCI Express slots.
>> Efi machines does not have an e820 memory map.
> 
> The EFI code really should fill in the e820 memory map instead fo making 
> up its own routines (and doing it badly at that).
> 
> There's nothing wrong with the e820 table, and we should consider it just 
> the "firmware memory map", and not care how it's filled in (whether it's 
> EFI or a real e820 BIOS call).
> 
> Quite frankly, right now I'm more likely to rip out the EFI code than 
> start adding even more (broken) support for it.
> 
> On the Intel Macs, upgrading the firmware turns it into a perfectly usable 
> machine.
> 
> 		Linus
> 

