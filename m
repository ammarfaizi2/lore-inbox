Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTJMOM4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTJMOM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:12:56 -0400
Received: from deepthot.org ([68.14.232.127]:16808 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S261793AbTJMOMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:12:54 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Re: Problems with Maxtor 120 GB drive
Date: Mon, 13 Oct 2003 13:23:59 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbol9rf.1uu.denebeim@hotblack.deepthot.org>
References: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
X-SA-Exim-Mail-From: news@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>, Jay Denebeim wrote:

> I just purchased a Maxtor 120GB MXTL01P120 hard drive and when I tried
> to install it with Redhat it wrote over the partition table describing
> it as only 8GB.  I tried doing linux rescue and lilo complained that
> the physical and logical disk sizes did not match (logical was the
> correct size, physical was the 8GB).
> 
> Any idea what could be causing this?

I ended up getting a good answer to this question.  Thanks to everyone
who answered, especially Stuart Longland who gave me the right answer.

I'm not sure precisely what caused this.  It probably has something to
do with the BIOS I suppose.  I don't know how this part of the kernel
works.

Anyway, to fix the problem is had to give lba32 as a kernel option
when booting the kernel.  That upped my max from 8GB to 32GB.  The
other thing I had to do was make my new drive the master and the old
drive the slave.  That allowed the system to see all the drive.

Is should be noted that I have a new motherboard in this system.  The
old 20Gig drive was exibiting the same 8Gig problem without the LBA32
switch. So it must be the BIOS that is the problem.  It's an AMI bios,
and unfortunately the machine belongs to my SO so I can't type the
version at the moment.

Hope this helps someone in the future
Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
