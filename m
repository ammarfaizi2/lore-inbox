Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCGWZa>; Thu, 7 Mar 2002 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCGWZV>; Thu, 7 Mar 2002 17:25:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56324 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293181AbSCGWZI>;
	Thu, 7 Mar 2002 17:25:08 -0500
Message-ID: <3C87E859.427EC3C7@zip.com.au>
Date: Thu, 07 Mar 2002 14:23:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87E35E.B841801D@zip.com.au> <Pine.LNX.4.44L.0203071908380.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>
> > So what *is* a solution.  Well, there's only so much memory available.
> > In either case a) or case b) we're "fairly" distributing that memory
> > between all files.  And that's the problem.  *All* the files have too
> > small a readahead window.  Which points one at: we need to stop being
> > fair. We need to give some files a good readahead window and others
> > not.   The "soft pinning" which I propose with GFP_READAHEAD and
> > PG_readhead might have that effect, I think.
> 
> Actually, it could boil down to something more:
> 
> use-once reduces the VM to FIFO order, which suffers from
> belady's anomaly so it doesn't matter much how much memory
> you throw at it
> 
> drop-behind will suffer the same problem once the readahead
> memory is too large to keep in the system, but at least the
> already-used pages won't kick out readahead pages

err..  Was there a fix in there somewhere, or are we stuck?

-
