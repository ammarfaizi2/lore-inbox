Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSJ1DcA>; Sun, 27 Oct 2002 22:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSJ1DcA>; Sun, 27 Oct 2002 22:32:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:10472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262821AbSJ1DcA>;
	Sun, 27 Oct 2002 22:32:00 -0500
Message-ID: <3DBCB123.5969FCC0@digeo.com>
Date: Sun, 27 Oct 2002 19:38:11 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM BUG, set_page_dirty() buggy?
References: <20021025094715.GF12628@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2002 03:38:11.0943 (UTC) FILETIME=[70B97770:01C27E33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> Hi,
> 
> I'm seeing what looks like a bug in set_page_dirty() in 2.5.44 (and
> 2.5.44-mm5), pages are being dumped.

It's not set_page_dirty() or direct IO.  There's a fairly long-standing
bug in the writeback code which can cause the kernel to never write out
ext2 indirect blocks.  Complete bastard of a thing it was, too.

I'll send out the fix shortly.
