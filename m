Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTGKUMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTGKUL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:11:28 -0400
Received: from CPE-65-29-18-15.mn.rr.com ([65.29.18.15]:24508 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S264679AbTGKUKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:10:12 -0400
Subject: Re:  Very HIGH File & VM system latencies and system stop
	responding while extracting big tar  archive file.
From: Shawn <core@enodev.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       rathamahata@php4.ru,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711183950.GB976@matchmail.com>
References: <3F0E8A22.6020700@cyberone.com.au>
	 <20030711034510.30065dc2.akpm@osdl.org>
	 <20030711183950.GB976@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057955087.12674.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 15:24:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 13:39, Mike Fedyk wrote:
> > No, this will be the reiserfs bug.
> 
> Is this in 2.5.75, or -mm?
You really should read the patch header... It tells you everything you
need to know.

> > --- 25/fs/reiserfs/tail_conversion.c~reiserfs-dirty-memory-fix	2003-07-10 22:22:54.000000000 -0700
> > +++ 25-akpm/fs/reiserfs/tail_conversion.c	2003-07-10 22:22:54.000000000 -0700
> > @@ -191,7 +191,7 @@ unmap_buffers(struct page *page, loff_t 
> >  	bh = next ;
> >        } while (bh != head) ;
> >        if ( PAGE_SIZE == bh->b_size ) {
> > -	ClearPageDirty(page);
> > +	clear_page_dirty(page);
> >        }
> >      }
> >    } 
> > 
> > _
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
