Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTDCXvD (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDCXvD (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:51:03 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:5905 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263575AbTDCXvB (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 18:51:01 -0500
Date: Fri, 4 Apr 2003 02:02:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Brandon Low <lostlogic@gentoo.org>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: Gentoo Linux BUG 18612 - cfdisk
Message-ID: <20030404000228.GA14072@win.tue.nl>
References: <20030403171148.GI26830@lostlogicx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403171148.GI26830@lostlogicx.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 11:11:48AM -0600, Brandon Low wrote:

> http://bugs.gentoo.org/show_bug.cgi?id=18612
> 
> This bug appears to be caused by using cfdisk's default allocation
> on the last partition on a drive.  From the looks of it on the user's
> LBA mapped drive, cfdisk allocated a bunch of non-existant sectors
> when the user allowed it to pick the default size for that last partition.

(please break lines)

(in case something is wrong with cfdisk, tell the cfdisk maintainer,
not the kernel list)

(what kernel version is this? - I see, 2.4.20)

According to WD, this disk has 78,165,360 sectors.
So, in case it was partitioned with such a size maybe nothing was wrong.

The boot messages shown say:
  kenny kernel: hda: setmax LBA 78165360, native  78125000
How come setmax has the right value and native has not?
Did other software clip the disk?
What is the identify data for this drive?

Was the partitioning done with a kernel that had CONFIG_IDEDISK_STROKE
enabled?


Andries

