Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265553AbUEZMmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUEZMmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265562AbUEZMmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:42:31 -0400
Received: from pdbn-d9bb9e9e.pool.mediaWays.net ([217.187.158.158]:11786 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265553AbUEZMhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:37:43 -0400
Date: Wed, 26 May 2004 14:37:40 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526123740.GA14584@citd.de>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47278.6090309@yahoo.com.au> <20040526105837.GA13810@citd.de> <40B47D4C.6050206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B47D4C.6050206@yahoo.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> Matthias Schniedermeyer wrote:
> >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> 
> OK, this is obviously bad. Do you get this behaviour with 2.6.5
> or 2.6.6? If so, can you strace the program while it is writing
> an ISO? (just send 20 lines or so). Or tell me what program you
> use to create them and how to create one?

To use other words, this is the typical case where a "hint" would be
useful.

program to kernel: "i read ONCE though this file caching not useful".

The last thing i knew in this area is that there exist a thing to tell
the kernel to drop all cache after the file is closed. (IIRC!)

But this doesn't help in this case as the image-file is up to 4,4GB in
whole which means that it ALONE can fill up the whole cache. Taking
aside the files the image was created from, which can (with a size of up
to 2GB (size-limit of iso9660-filesystem/linux-kernel)) also fill a lot
of cache until they are closed.

(The/My) typical case is this.
1 create image-file
2 remove source-files
3 burn image
4 remove image-file

Step 1 and 3 trash the cache without ANY positive effect.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

