Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318666AbSHAItr>; Thu, 1 Aug 2002 04:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318669AbSHAItr>; Thu, 1 Aug 2002 04:49:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318666AbSHAItq>;
	Thu, 1 Aug 2002 04:49:46 -0400
Message-ID: <3D48F915.3FADA08F@zip.com.au>
Date: Thu, 01 Aug 2002 02:02:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
References: <20020801074953.GJ1644@suse.de> <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva> <20020801081010.GA1096@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> > Anyway, lets wait for the numbers.
> 
> It just 'feels' like the sort of change that might have odd side
> effects.

It's almost impossible to get READA to do anything.  For example, in
current 2.5, if a READA attempt is actually aborted, end_buffer_io_sync
reports a "buffer I/O error".  Every time. And nobody has reported this.

It _is_ possible to hit this in 2.5, because of ext2_preread_inode().

Probably, also it's possible to hit it in 2.4 with hundreds of processes
all issuing ext3 directory readahead.  But it's pretty remote.
