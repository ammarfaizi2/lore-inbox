Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUGVPI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUGVPI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUGVPHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:07:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40414 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266311AbUGVPGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:06:51 -0400
Date: Thu, 22 Jul 2004 10:54:50 -0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
Message-ID: <20040722125450.GC3987@suse.de>
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de> <40FBBAAE.5060405@comcast.net> <40FC2E60.2030101@comcast.net> <40FF4563.5070407@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FF4563.5070407@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22 2004, Ed Sweetman wrote:
> I've had other people test writing.  It appears that scsi-emu is not 
> effected by this memory leak when writing audio cds.  So it would appear 
> that ide-cd along with any of the dependent ide source files is the 
> culprit. But I cannot find anywhere in ide-cd that is apparent to being 
> a mem leak.  There are various conditions in ide_do_drive_cmd that state 
> that the cdrom driver has to be very careful about handling but without 
> intimate knowledge of the driver, I can't be sure that it's sufficiently 
> handling those situations.  
> 
> Surprisingly, it's very hard to find anyone who's used the native atapi 
> mode to write an audio cd in 2.6.  Which is partly why this problem 
> hasn't generated more mail traffic here I would guess. 

That's not true, lots of people use it. But, oddly, the leak isn't
reproducable on any machine I've tested.

-- 
Jens Axboe

