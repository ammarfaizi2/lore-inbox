Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTJOERF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTJOERF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:17:05 -0400
Received: from deepthot.org ([68.14.232.127]:63105 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S262297AbTJOERB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:17:01 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Re: Problems with Maxtor 120 GB drive
Date: Wed, 15 Oct 2003 03:50:31 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnboph07.2kt.denebeim@hotblack.deepthot.org>
References: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org> <slrnbol9rf.1uu.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
X-SA-Exim-Mail-From: news@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In dt.kernel, you wrote:
> In article <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>, Jay Denebeim wrote:
> 
>> I just purchased a Maxtor 120GB MXTL01P120 hard drive and when I tried
>> to install it with Redhat it wrote over the partition table describing
>> it as only 8GB.  I tried doing linux rescue and lilo complained that
>> the physical and logical disk sizes did not match (logical was the
>> correct size, physical was the 8GB).
>> 
>> Any idea what could be causing this?
> 
> I ended up getting a good answer to this question.  Thanks to everyone
> who answered, especially Stuart Longland who gave me the right answer.
> 
> I'm not sure precisely what caused this.  It probably has something to
> do with the BIOS I suppose.  I don't know how this part of the kernel
> works.
> 
> Anyway, to fix the problem is had to give lba32 as a kernel option
> when booting the kernel.  That upped my max from 8GB to 32GB.  The
> other thing I had to do was make my new drive the master and the old
> drive the slave.  That allowed the system to see all the drive.
> 
> Is should be noted that I have a new motherboard in this system.  The
> old 20Gig drive was exibiting the same 8Gig problem without the LBA32
> switch. So it must be the BIOS that is the problem.  It's an AMI bios,
> and unfortunately the machine belongs to my SO so I can't type the
> version at the moment.

But, it's not helping me aparently.  This morning the system would no
longer boot.  I got a call from my SO while I was driving home from
work today (my commute is 240 miles round trip) so I tried to talk her
through putting grub back on the system.  Somehow the drive ended up
getting formatted, and now I'm back at square one.  Unfortunately this
time the linux lba32 boot is no longer working.  It won't recognize
either of the drives as being more than 8 gig.

I suspect this is a motherboard/bios issue, the motherboard is an
ECS 'K7S5A Pro'. (www.ecsusa.com), the bios is an AMIBIOS simple setup
utility Version 1.21.11.  The distro is redhat 9 straight off of the
CD.  There doesn't seem to be anything on it to select large LBAs.

Any help would be greatly appreciated even a "I know that mobo is no
good with linux, get another one" would be useful since we've only had
it a couple of weeks and could probably return it.  (Which I would
have done already, except that it was the only one Frys carried that
would take the brand new SDram (not DDR) we bought for the previous
motherboard which then proceeded to smoke after the next power hit.
(Yes, I've been having a very frustrating month with the SO's
computer.))

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
