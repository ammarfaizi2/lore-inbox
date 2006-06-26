Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933073AbWFZVds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073AbWFZVds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbWFZVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:33:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933073AbWFZVdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:33:47 -0400
Date: Mon, 26 Jun 2006 14:33:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
In-Reply-To: <44A04F5F.8030405@ed-soft.at>
Message-ID: <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Edgar Hucek wrote:
>
> Fix EFI boot on 32 bit machines with PCI Express slots.
> Efi machines does not have an e820 memory map.

The EFI code really should fill in the e820 memory map instead fo making 
up its own routines (and doing it badly at that).

There's nothing wrong with the e820 table, and we should consider it just 
the "firmware memory map", and not care how it's filled in (whether it's 
EFI or a real e820 BIOS call).

Quite frankly, right now I'm more likely to rip out the EFI code than 
start adding even more (broken) support for it.

On the Intel Macs, upgrading the firmware turns it into a perfectly usable 
machine.

		Linus
