Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSEBLKc>; Thu, 2 May 2002 07:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314352AbSEBLKb>; Thu, 2 May 2002 07:10:31 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:11458 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S314351AbSEBLKa>; Thu, 2 May 2002 07:10:30 -0400
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 2 May 2002 07:10:14 -0400
MIME-Version: 1.0
Subject: Re: [STATUS 2.5]  May 1, 2002 (BKL status)
CC: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Message-ID: <3CD0E656.5451.7D1A7885@localhost>
In-Reply-To: <3CD0047B.4060605@us.ibm.com>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I may not be the leading BKL expert, but I play one on TV :)
> 
> Perhaps one of the kernel-janitor people would like to assist me with 
> this (cc'ing that list).  I'd be willing to keep a web page to list all 
> current BKL uses and keep track of them as they are removed/added 
> Perhaps a set of web pages which resemble the directory structure of the 
> kernel tree would be helpful??
> 
> Here's a good question for kernel-janitor, and anyone else who's 
> interested, what format describing BKL use would most encourage you to 
> go and remove it?  We already have Rick Lindsley's Global spinlock list: 
>   http://prdownloads.sourceforge.net/lse/locking_doc-2.4.16 .  The BKL 
> use in there is somewhat dated, but might be a good start.
> 
> I have some awk scripts that I use on each new kernel release to check 
> for new and removed uses of the BKL.  I can adapt these to start 
> checking new BK changesets for BKL changes.

I'm by no means a BKL expert, not even on TV  :-) , but here is a 
suggestion.
What about a listing sorted by how the BKL should be replaced, 
something like this:

BKL --> dma_spin_lock
- alpha/kernel/ptrace.c  Held while doing a ptrace      (John Doe)
- drivers/block/rd.c  Held while doing whatever         (?)
- ...

BKL --> xprt_lock
- ...

BKL --> no lock required
- ...

BKL instances that will NOT be removed
- ...

The advantage is that it should be easier to group together instances
that require the same type of work.
Comments?

-- Guillaume




