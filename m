Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264435AbTIIUWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTIIUUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:20:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264493AbTIIUQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:16:37 -0400
Date: Tue, 9 Sep 2003 22:16:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atapi write support? No
Message-ID: <20030909201645.GS4755@suse.de>
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de> <3F5E338F.2000007@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E338F.2000007@wmich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09 2003, Ed Sweetman wrote:
> Jens Axboe wrote:
> >On Tue, Sep 09 2003, Ed Sweetman wrote:
> >
> >>Is anyone able to actually use the atapi write support present in the 
> >>later cdrecord releases?  2.6 can't seem to work with it at all.  Is 
> >
> >
> >Based on the clues you pass above, noone can help you. What are you
> >trying to do and how? What kernel version? What cdrecord version?
> 
> There is no other information needed. By use atapi write support i mean 
> Get it to do anything besides error out reporting that it cant access 
> the drive. If you can query the drive much less actually write anything 

That's no info in itself. Clearly you have never had to deal with any
sort of support, or you would know that you should not post and ask for
help in such a way.

> to it using the ATAPI interface than that's more than i've been able to do.
> 
> for example   cdrecord dev=ATAPI:1,0,0 checkdisk
> 
> 1,0,0 should conform to secondary channel master as this is how devfs 
> sets the cdr up too.

And a quick seach of lkml would have shown you that you should use
dev=/dev/hdX.

> cdrecord version: atapi support was introduced with 2.0 but again, for 
> the sake of comparison, anything after a13.

You must mistake that support for something else. Support for block
SG_IO was introduced with 1.11a37 iirc, so anything later than that
should work.

-- 
Jens Axboe

