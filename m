Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSGLPts>; Fri, 12 Jul 2002 11:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSGLPtr>; Fri, 12 Jul 2002 11:49:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316598AbSGLPtq>; Fri, 12 Jul 2002 11:49:46 -0400
Date: Fri, 12 Jul 2002 16:52:33 +0100
From: Russell King <rmk+ext3@arm.linux.org.uk>
To: Alec Smith <alec@shadowstar.net>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 corruption
Message-ID: <20020712165233.B10576@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207121127001.7507-100000@bugs.home.shadowstar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207121127001.7507-100000@bugs.home.shadowstar.net>; from alec@shadowstar.net on Fri, Jul 12, 2002 at 11:32:44AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:32:44AM -0400, Alec Smith wrote:
> Over the last month or so, I've noticed the following error showing up
> repeatedly in my system logs under kernel 2.4.18-ac3 and more recently
> under 2.4.19-rc1:
> 
> EXT3-fs error (device ide0(3,3)) in ext3_new_inode: error 28

Erm, that looks like the old "out of inodes, return -ENOSPC and mark the
filesystem read only" bug I found several months ago.  iirc, there have
been 3 recent issues (in the last three months) that I'm aware of:

1. running out of free blocks.
2. running out of free inodes.
3. i_nlink accounting goofup.

I've got patches from akpm for (1) and (3), but not (2).  I'd be nice to
have all three solved for 2.4.19.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

