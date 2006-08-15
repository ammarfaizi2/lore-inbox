Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWHOFnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWHOFnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 01:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWHOFnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 01:43:33 -0400
Received: from brick.kernel.dk ([62.242.22.158]:64519 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965103AbWHOFnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 01:43:32 -0400
Date: Tue, 15 Aug 2006 07:45:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Getting 'sync' to flush disk cache?
Message-ID: <20060815054513.GG16819@suse.de>
References: <fa.W0uMWcngieRXsM23OSdM5c2wdZI@ifi.uio.no> <fa.qZ/OWlxPTq6xK9TZx+9e39itX9k@ifi.uio.no> <fa.PWNfC1odploxRBgLE1vdR69UF9s@ifi.uio.no> <44E10293.7000508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E10293.7000508@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14 2006, Robert Hancock wrote:
> Jens Axboe wrote:
> >On Mon, Aug 14 2006, Arjan van de Ven wrote:
> >>On Mon, 2006-08-14 at 14:39 -0400, Jeff Garzik wrote:
> >>>So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
> >>>and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?
> >>>
> >>>This has bugged me for _years_, that Linux does not do this.  Looking at 
> >>>forums on the web, it bugs a lot of other people too.
> >>eh afaik 2.6.17 and such do this if you have barriers enabled...
> >
> >That is correct, but it only works on reiserfs and XFS and user space
> >really cannot tell whether it did the right thing or not. File system
> >developers really should take this more seriously...
> >
> 
> I was under the impression that this just worked under recent kernels. 
> I'm disappointed to hear that it doesn't. It always annoys me that 
> issues like this sometimes just seem to stick around forever in the 
> kernel without getting the attention they should (and tend not to be 
> well documented either..)

It is an embarassment that it doesn't just work. For the longest time,
it seemed nobody really cared about it enough to get it fixed. At least
now it's gathering a bit of momentum.

-- 
Jens Axboe

