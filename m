Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318670AbSHAIzH>; Thu, 1 Aug 2002 04:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318675AbSHAIzH>; Thu, 1 Aug 2002 04:55:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41344 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318670AbSHAIzG>;
	Thu, 1 Aug 2002 04:55:06 -0400
Date: Thu, 1 Aug 2002 10:58:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020801085829.GD1096@suse.de>
References: <20020801074953.GJ1644@suse.de> <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva> <20020801081010.GA1096@suse.de> <3D48F915.3FADA08F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D48F915.3FADA08F@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > ...
> > > Anyway, lets wait for the numbers.
> > 
> > It just 'feels' like the sort of change that might have odd side
> > effects.
> 
> It's almost impossible to get READA to do anything.  For example, in
> current 2.5, if a READA attempt is actually aborted, end_buffer_io_sync
> reports a "buffer I/O error".  Every time. And nobody has reported this.

Ahem, I've actually seen that happen :-). But maybe a total of 20 times
or so.

> It _is_ possible to hit this in 2.5, because of ext2_preread_inode().
> 
> Probably, also it's possible to hit it in 2.4 with hundreds of processes
> all issuing ext3 directory readahead.  But it's pretty remote.

Alright, I'm happy then.

-- 
Jens Axboe

