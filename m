Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbQLVBrr>; Thu, 21 Dec 2000 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131716AbQLVBrh>; Thu, 21 Dec 2000 20:47:37 -0500
Received: from web10101.mail.yahoo.com ([216.136.130.51]:32521 "HELO
	web10101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131712AbQLVBrT>; Thu, 21 Dec 2000 20:47:19 -0500
Message-ID: <20001222011652.30206.qmail@web10101.mail.yahoo.com>
Date: Thu, 21 Dec 2000 17:16:52 -0800 (PST)
From: Al Peat <al_kernel@yahoo.com>
Subject: Re: Purging the Page Table (was: Purging the Buffer Cache)
To: linux-kernel@vger.kernel.org
Cc: myself <al_peat@yahoo.com>, Juri Haberland <juri.haberland@innominate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Juri Haberland <juri.haberland@innominate.com>
wrote:
> Al Peat wrote:
> > 
> >   Is there any way to completely purge the buffer
> > cache -- not just the write requests (ala 'sync'
> or
> > 'update'), but the whole thing?  Can I just call
> > invalidate_buffers() or destroy_buffers()?
>
> What about the ioctl BLKFLSBUF ?
> If you are running a SuSE distrib there is already a
> tool called flushb
> that does what you want. If not, you can download
> the simple tool from
> http://innominate.org/~juri/flushb.tar.gz

  Another question: what if I need to purge the page
table of all files as well?  Is there a clean way to
do that?  I've been looking at /mm/memory.c, but it
doesn't look like clear_page_tables, etc. get
exported.

  I need /all/ read requests to go to disk, and it'd
be nice if I could do that without a reboot (but I'll
take the reboot if that's the only way to go about it
:)

  Thanks again,
  	Al

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
