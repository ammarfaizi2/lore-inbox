Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131238AbRBUBeE>; Tue, 20 Feb 2001 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRBUBdz>; Tue, 20 Feb 2001 20:33:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8965 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131238AbRBUBdq>;
	Tue, 20 Feb 2001 20:33:46 -0500
Date: Wed, 21 Feb 2001 02:33:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: loop-5
Message-ID: <20010221023312.J1447@suse.de>
In-Reply-To: <3A931A3C.8050000@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A931A3C.8050000@lycosmail.com>; from ajschrotenboer@lycosmail.com on Tue, Feb 20, 2001 at 08:30:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20 2001, Adam Schrotenboer wrote:
> Jens,
> 
> Please excuse this possibly stupid q. I don't know as much about kernel 
> hacking as I would like to.
> 
> I noticed that you are rewriting the loop block device to be a block 
> remapper (yes, I had noticed this before, the q just never occurred to 
> me before); does this imply that the native block size of the loop file 
> fs must be the same size as the underlying fs? exemplia gratia, ext2 fs 
> w/ block size 1024, iso image block size 2048; or ext2 block size 1024, 
> reiserfs image block size 512 (I'm assuming this is possible, but don't 
> know for sure. of course on reiserfs the likely best size is 4096 to 
> match page size, since tails are packed anyway); or perhaps a more 
> useful/common example than the previous: iso block size 2048, ext2 block 
> size 1024 (most common block size, right??).

A remapper was the original idea, and the loop-remap-XX patches did
that. But it gave me so many head aches exactly due to for example
block size differences, and also the stacking then becomes even
more problematic.

So no, the current loop patches do not use simple buffer_head
remapping.

-- 
Jens Axboe

