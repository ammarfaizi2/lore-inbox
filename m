Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266715AbRGPRz1>; Mon, 16 Jul 2001 13:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267461AbRGPRzR>; Mon, 16 Jul 2001 13:55:17 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:28932 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S266715AbRGPRzA>;
	Mon, 16 Jul 2001 13:55:00 -0400
From: tpepper@vato.org
Date: Mon, 16 Jul 2001 10:55:01 -0700
To: linux-kernel@vger.kernel.org
Subject: blkdev_get|put and how to get excl blk dev access w/i the kernel
Message-ID: <20010716105501.A31759@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed some "locking" functions in the md driver which gave me the
impression of giving exclusive access to a block device.  The functions
make use of:

	bdget
	blkdev_get
	blkdev_put
	bdput

These aren't particularly documented that I've seen and I haven't traced
through enough code to figure out for sure what exactly they'd lock and
not lock.  But I've been playing around with them just to see what I could
do with an sd device which I'd "locked".  It seems like I'm unable to run
fdisk against the disk, but other than that I can read/write (using dd)
the sd device without a problem.  Is this what's supposed to happen?

If so, is there anything else I can do to get exclusive use of a system
device (especially particular sd and sg devices) from within the kernel?
This seems like it would be a generally desireable feature, although
I can understand people taking the stance of "if the sysadmin wants to
shoot themselves in the foot by writing to an sd directly instead of to
the filesystem mounted on that sd...more power to them."  That's kind of my
thought, but somebody (my employer) wants this from me.

Tim

--
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
