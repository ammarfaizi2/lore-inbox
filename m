Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbTGBLEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 07:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264951AbTGBLEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 07:04:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61357 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264946AbTGBLEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 07:04:12 -0400
Date: Wed, 2 Jul 2003 13:18:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Attila Kinali <kinali@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom blocksize reset bug with 2.4.x kernels
Message-ID: <20030702111835.GC839@suse.de>
References: <20030702002558.7faf6c88.kinali@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702002558.7faf6c88.kinali@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02 2003, Attila Kinali wrote:
> Hi,
> 
> After some discussion on the mplayer-users mailinglist about
> that for some scsi drives it's impossible to read a data cd
> after reading a vcd/scvd until the next reboot.
> (see http://mplayerhq.hu/pipermail/mplayer-users/2002-December/025696.html)
> 
> I found that there is a reset of the cdrom block size needed
> for those drives which doesnt restet it themselfs if a new
> cd is put in (looks like only a few scsi cdroms are affected)
> 
> Attached is a small patch for drivers/cdrom/cdrom.c that fixes 
> this for the 2.4.20 kernel (and also for 2.4.21 as the code didn't
> change). It's reseting the blocksize when a cdrom is opened for
> the first time (meaning that a umount/mount cycle can reset
> the blocksize).
> 
> I run this code now for about half a year and didnt have any problems.
> But, as i didnt get any feadback from other people, i'm not sure if
> everything is correct.

If you clean this up wrt coding style, it can go in.

-- 
Jens Axboe

