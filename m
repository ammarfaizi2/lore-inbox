Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUAHO65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUAHO65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:58:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12777 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264954AbUAHO6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:58:54 -0500
Date: Thu, 8 Jan 2004 15:58:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: blockfile access patterns logging
Message-ID: <20040108145851.GB8774@suse.de>
References: <20040108120008.GA7415@outpost.ds9a.nl> <200401081430.i08EUVfx005021@turing-police.cc.vt.edu> <20040108143908.GA8688@suse.de> <200401081454.i08EsZBu005830@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401081454.i08EsZBu005830@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08 2004, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 08 Jan 2004 15:39:08 +0100, Jens Axboe said:
> 
> > For laptops, it's often most interesting to find out _what_ process
> > dirtied what data (which in turn caused bdflush to sync it), or what
> > process keeps doing small reads. And block_dump does exactly that (it
> > was invented for exactly that purpose :)
> 
> I submit that "what process ID did it" is even more remote from the disk
> than "what inode" ;)

There are no inodes involved at that point, it's left the fs and is
purely in area between block layer and disk driver. Besides, what would
do with the inode for this problem? If you really want to find eg the
file in question (if you cannot _guess_ when you know the process), then
you could go back from the block number. I've never ever had a need to
go that far, though.

-- 
Jens Axboe

