Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRHXROx>; Fri, 24 Aug 2001 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272264AbRHXROm>; Fri, 24 Aug 2001 13:14:42 -0400
Received: from home.linux3d.org ([216.86.203.152]:50940 "EHLO harlot.rb.ca.us")
	by vger.kernel.org with ESMTP id <S272263AbRHXROY>;
	Fri, 24 Aug 2001 13:14:24 -0400
Date: Fri, 24 Aug 2001 10:14:39 -0700
From: Daryll Strauss <daryll@valinux.com>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: software raid does not do parallel reads under 2.4?
Message-ID: <20010824101439.C1717@newbie>
In-Reply-To: <20010823234218.B12873@cerebro.laendle> <15238.11161.492557.264988@notabene.cse.unsw.edu.au> <3B868874.B89B04DE@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B868874.B89B04DE@gmx.at>; from Wilfried.Weissmann@gmx.at on Fri, Aug 24, 2001 at 07:01:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 07:01:40PM +0200, Wilfried Weissmann wrote:

> I experienced some performance loss when moving from kernel 2.4.4 to
> 2.4.7-ac3 regarding ide harddisks. I am useing the hpt ataraid driver
> which does pretty much the same thing as the md disk striping driver.
> I/O speed of the raid volume is about as fast as accessing a single
> drive.
> There were a lot of ide reports some time ago. Maybe they where problems
> with concurrent I/O operations...?

I'm seeing similar behavior with SCSI. I've got two SCSI channels. If I
run two dd's each talking to disks on different channels, I get 2x disk
bandwidth. If I run two dd's talking to disks on the same channel I get
1x disk bandwidth. This is with 2.4.9, but I haven't isolated which
kernel versions cause this.

This system has 8 U160 disks spread over 2 U160 channels and it hasn't
been deployed yet, so if I can help with testing, let me know.

						- |Daryll

