Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWHNUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWHNUOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWHNUOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:14:07 -0400
Received: from brick.kernel.dk ([62.242.22.158]:3923 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932693AbWHNUOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:14:05 -0400
Date: Mon, 14 Aug 2006 22:15:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Getting 'sync' to flush disk cache?
Message-ID: <20060814201545.GE16819@suse.de>
References: <44E0C373.6060008@garzik.org> <1155584098.2886.271.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155584098.2886.271.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14 2006, Arjan van de Ven wrote:
> On Mon, 2006-08-14 at 14:39 -0400, Jeff Garzik wrote:
> > So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
> > and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?
> > 
> > This has bugged me for _years_, that Linux does not do this.  Looking at 
> > forums on the web, it bugs a lot of other people too.
> 
> eh afaik 2.6.17 and such do this if you have barriers enabled...

That is correct, but it only works on reiserfs and XFS and user space
really cannot tell whether it did the right thing or not. File system
developers really should take this more seriously...

-- 
Jens Axboe

