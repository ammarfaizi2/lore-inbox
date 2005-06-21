Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVFUAts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVFUAts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFUAtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:49:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261772AbVFUAcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:32:06 -0400
Date: Mon, 20 Jun 2005 20:32:04 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
Message-ID: <20050621003203.GB28908@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:07:34AM -0400, Richard B. Johnson wrote:
 > 
 > Attempts to run a driver that worked up to 2.6.11.9 shows that
 > it aparently is no longer possible to nest calls to `down`.
 > In other words, a procedure that has taken a semaphore can't
 > then take another semaphore.
 > 
 > 	down(&first_resource);
 > 	down(&second_resource);
 > 	...
 > 	...
 > 	up(&second_resource);
 > 	up(&first_resource);
 > 
 > 
 > The error is 'sleeping function called from invalid context....'
 > 
 > ------------[ cut here ]------------
 > kernel BUG at mm/memory.c:1112!
 > invalid operand: 0000 [#1]
 > PREEMPT SMP 
 > Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm l2cap 
 > bluetooth nfsd exportfs lockd sunrpc e100 mii ipt_REJECT ipt_state 
 > ip_conntrack iptable_filter ip_tables floppy sg sr_mod microcode nls_cp437 
 > msdos fat dm_mod uhci_hcd ehci_hcd video container button battery ac rtc 
 > ipv6 ext3 jbd ata_piix libata aic7xxx scsi_transport_spi sd_mod scsi_mod
 > CPU:    0
 > EIP:    0060:[<c01577f0>]    Not tainted VLI

Where is the source for this HeavyLink module ? The lack of tainting implies
that it is GPL ?  Oh wait, you've been asked this before[1], but
chose to ignore it.

Remind me again, why you expect any help from linux-kernel, when you've
previously gone out of your way to encourage the subversion of the
gpl-checking mechanisms in the kernel[2], and have no aparent intentions
of showing the code at fault.

		Dave

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/1690.html
[2] http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.2/0609.html

