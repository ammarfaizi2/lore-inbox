Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131641AbRCMVh6>; Tue, 13 Mar 2001 16:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRCMVgA>; Tue, 13 Mar 2001 16:36:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131211AbRCMVeT>;
	Tue, 13 Mar 2001 16:34:19 -0500
Date: Tue, 13 Mar 2001 19:43:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Mark Shewmaker <mark@primefactor.com>
Cc: Brian Dushaw <dushaw@munk.apl.washington.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux kernel - and regular sync'ing?
Message-ID: <20010313194308.A2536@flint.arm.linux.org.uk>
In-Reply-To: <20010308223319.A25679@flint.arm.linux.org.uk> <Pine.LNX.4.30.0103081439400.18253-100000@munk.apl.washington.edu> <20010312142702.A28863@primefactor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010312142702.A28863@primefactor.com>; from mark@primefactor.com on Mon, Mar 12, 2001 at 02:27:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2001 at 02:27:02PM -0500, Mark Shewmaker wrote:
> It's probably very much worth it for you to keep your /etc/fstab as you've
> edited it, but I did want to warn you that the noatime option can
> still unexpectedly break programs that make quite reasonable assumptions.

Easy workaround - place your /home and /var trees on separate filesystems
and mount /home normally.  Make /var "nodiratime" so accessing directories
doesn't update their atime.  Make / "noatime".

This is basically what I've been running here for the past couple of years
and it seems fine for me.  Your milage may vary though (depending on what
software you run).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

