Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbULVTwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbULVTwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbULVTwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 14:52:13 -0500
Received: from bender.bawue.de ([193.7.176.20]:44243 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S262023AbULVTwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 14:52:09 -0500
Date: Wed, 22 Dec 2004 20:52:03 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041222195203.GA24857@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Christoph Hellwig <hch@infradead.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041221185754.GA28356@sommrey.de> <20041222182606.GA14733@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222182606.GA14733@infradead.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 06:26:06PM +0000, Christoph Hellwig wrote:
> On Tue, Dec 21, 2004 at 07:57:54PM +0100, Joerg Sommrey wrote:
> > Hello,
> > 
> > last night my box died with a kernel oops.  There was a backup
> > running at that time. The setup:
> > - 2 SATA disks + 1 SCSI disk
> > - SATA partitions build up md-raid-arrays (level 0 and 1)
> > - md-raid-devices and SCSI partitions are physical volumes for dm
> > - dm logical volumes are used for xfs filesystems
> > - backup is done on dm-snapshots of those filesystems
> 
> Given the strange backtrace and this enormous stack of drivers I bet
> you're seeing a stack overflow.  
> 
Does this mean that this kind of stuff just doesn't work?  I was running
a 4K-stack kernel with this "stack of drivers" for quiet some time without
problems.  The problems started around 2.6.9-pre-something.  Converting
to 8K-stacks didn't help.  Is this only xfs related?

-jo

-- 
-rw-r--r--  1 jo users 63 2004-12-21 21:16 /home/jo/.signature
