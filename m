Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWCBOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWCBOrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCBOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:47:19 -0500
Received: from kilius.dnsgold.net ([212.239.26.2]:6596 "EHLO
	kilius.dnsgold.net") by vger.kernel.org with ESMTP id S1751083AbWCBOrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:47:19 -0500
Message-ID: <002401c63e08$32016310$040010ac@Tesla>
From: "Paolo Roberti" <tesla@thgnet.it>
To: <sander@humilis.net>
Cc: <linux-kernel@vger.kernel.org>
References: <001501c63dfb$298d2780$040010ac@Tesla> <20060302134039.GB10924@favonius>
Subject: Re: My desperation: Oops during mkfs.ext3 on large partitions
Date: Thu, 2 Mar 2006 15:47:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - kilius.dnsgold.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thgnet.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Sander" <sander@humilis.net>
To: "Paolo Roberti" <tesla@thgnet.it>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 02, 2006 2:40 PM
Subject: Re: My desperation: Oops during mkfs.ext3 on large partitions


> Paolo Roberti wrote (ao):
>> I've tried remapping IRQs, switching PCI slots, removing unused PCI 
>> cards,
>> attaching this HD as slave and running mkfs.ext3 from a running system 
>> with
>> Red Hat 9 (i'd always been trying from a PXE booted Fedora Core 4). There
>> seems to be NO way to run mkfs from this computer.
>>
>> What drives me crazy is that badblocks (read and read/write) runs smooth,
>> so the partition is fully addressable from the PCI controller...
>
> Do you get any output at all from mkfs.ext3?
>

Yes, it was attached in my previous email. I tried with ext2 and mkfs.vfat 
also..same problem.
But.. I sorted it out a few minutes ago, it was due to failing RAM.

This is very unhappy because it was failing from 128MB on, out of 512 MB. 
BIOS was saying it was OK but memtest86 found out that it was returning 
always the same number. This is why badblocks was working even on 100GB 
partition while mkfs.ext3 was NOT, the first uses a few kB of ram while the 
latter seems to use a lot, running over the broken pages and causing kernel 
Oops and panics.

Thank you for your reply, it was very much appreciated. Replacing the broken 
RAM made everything working. I even replaced two HDs because of a data loss 
which actually was NOT due to an HD failure, but to the broken RAM! This is 
very unhappy. I must take out the HDs from the garbage...

Maybe linux kernel should run a very quick test for RAM, it would take less 
than a second to run and would save people a lots of troubles...

At least this time i learnt a very important lessons.

Thank you all for your attention.

Regards,
Paolo

