Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVKGVyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVKGVyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVKGVyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:54:25 -0500
Received: from mail.enyo.de ([212.9.189.167]:43431 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S965206AbVKGVyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:54:24 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: adam radford <aradford@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third of inode tables
References: <BEDEA151E8B1D6CEDD295442@192.168.100.25>
	<b1bc6a000511021459h1a2f5089q3b37b56460b7799d@mail.gmail.com>
	<98C5049497A78ECC77D350B7@[192.168.100.25]>
Date: Mon, 07 Nov 2005 22:53:54 +0100
In-Reply-To: <98C5049497A78ECC77D350B7@[192.168.100.25]> (Alex Bligh's message
	of "Sat, 05 Nov 2005 09:06:08 +0000")
Message-ID: <87br0wxgy5.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Bligh:

> I /think/ what had happened is this: When I press F8 to exit the
> BIOS, it did not initialize the array (this is in accordance with the
> manual, it being deferred). Despite leaving the machine idle in the O/S
> for 2 days, it didn't start initializing the array. Running the mkfs
> started the initialization (would that make sense)? The second time
> I ran mkfs, I may have already (somehow) triggered it to start earlier.
>
> I shall try and work out some soak test I can run on it this w/e.

Please check the write cache settings and report the results.
(There's a closed-source command line utility which can report the
status in an unambiguous way.)

If the system doesn't wait on I/O, this means that all I/O is cached
by the controller, which in turn suggests that the write cache is
turned on (with obvious consequences).
