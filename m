Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316159AbSETRTR>; Mon, 20 May 2002 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSETRTQ>; Mon, 20 May 2002 13:19:16 -0400
Received: from [195.223.140.120] ([195.223.140.120]:16964 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316159AbSETRTP>; Mon, 20 May 2002 13:19:15 -0400
Date: Mon, 20 May 2002 18:37:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <20020520163724.GI21806@dualathlon.random>
In-Reply-To: <20020520043040.GA21806@dualathlon.random> <1232380940.1021886032@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 09:13:53AM -0700, Martin J. Bligh wrote:
> Is it really the rmap patch, or is this Alan's VM as a whole?
> Could you take a look at http://www.surriel.com/patches/ and
> see if the rmap 13 patch there is still objectionable to you?

I think it's almost the same code.

> I've been benchmarking rmap 13 against mainline (2.4.19-pre7)
> and with the latest lock breakup changes performance now seems
> to be about equivalent to mainline (for kernel compile on NUMA-Q).
> Those changes reduced system time from 650s to 160s. The only

How much are you swapping in your workload? (as said the fast paths are
hurted a little so it's expected that it's almost as fast as mainline
with a kernel compile, similar to the fact we also add anon pages to the
lru list). I think you're only exercising the fast paths in your
workload, not the memory balancing that is the whole point of the change.

> reason I haven't published results "officially" yet is that I 
> was sorting out some timer problems with the machine.
> 
> M.


Andrea
