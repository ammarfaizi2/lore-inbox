Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316105AbSETQPR>; Mon, 20 May 2002 12:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316108AbSETQPQ>; Mon, 20 May 2002 12:15:16 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:46539 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316105AbSETQPP>; Mon, 20 May 2002 12:15:15 -0400
Date: Mon, 20 May 2002 09:13:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Bug with shared memory.
Message-ID: <1232380940.1021886032@[10.10.2.3]>
In-Reply-To: <20020520043040.GA21806@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About rmap design I would very much appreciate if Rik could make a
> version of his patch that implements rmap on top of current -aa (it
> wouldn't be a rewrite, just a porting of the strict rmap feature), 
> so we can compare apples to apples and benchmark the effect of the 
> rmap patch, not the rmap + the hybrid, most of the slowdown during 
> paging is most probably due the hybrid, not because of the rmap design, 
> the rmap design if something should make things a bit faster during 
> swapout infact, by being a bit slower in the more important fast paths. 
> It is definitely possible to put a strict rmap on top of -aa without 
> the huge "hybrid" thing attached to the rmap code, so without impacting 
> at all the rest of the vm. It's just a matter of adding the try_to_unmap 
> in shrink_cache and deleting the swap_out call (it's almost as easy as
> shipping a version of Windows without a web browser installed by default).

Is it really the rmap patch, or is this Alan's VM as a whole?
Could you take a look at http://www.surriel.com/patches/ and
see if the rmap 13 patch there is still objectionable to you?

I've been benchmarking rmap 13 against mainline (2.4.19-pre7)
and with the latest lock breakup changes performance now seems
to be about equivalent to mainline (for kernel compile on NUMA-Q).
Those changes reduced system time from 650s to 160s. The only
reason I haven't published results "officially" yet is that I 
was sorting out some timer problems with the machine.

M.

