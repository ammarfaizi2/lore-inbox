Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTLKFq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLKFq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:46:28 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:65155 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263584AbTLKFq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:46:26 -0500
From: David Lang <david.lang@digitalinsight.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Nick Piggin <piggin@cyberone.com.au>,
       Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 10 Dec 2003 22:30:16 -0800 (PST)
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
In-Reply-To: <20031211054111.GX8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312102228050.20930@dlang.diginsite.com>
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
 <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu>
 <20031211054111.GX8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed,
highmem isn't nessasary for mem<1G (actually 960M) on x86.

you are useing the opteron CPU, but was your kernel compiled for it
(x86064) or are you running an x86 kernel? (both will run, but the x86-64
kernel will give you better performance (including removing the need for
highmem)

David Lang

On Wed, 10 Dec 2003, William Lee Irwin III wrote:

> Date: Wed, 10 Dec 2003 21:41:11 -0800
> From: William Lee Irwin III <wli@holomorphy.com>
> To: Ed Sweetman <ed.sweetman@wmich.edu>
> Cc: Nick Piggin <piggin@cyberone.com.au>, Donald Maner <donjr@maner.org>,
>      Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
> Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB
>     ram.
>
> On Thu, Dec 11, 2003 at 12:33:39AM -0500, Ed Sweetman wrote:
> > I thought highmem wasn't necesarily needed for memory <=2GB? Highmem
> > incurs some performance hits doesn't it and so the urge to move to it
> > with only 2GB is not very attractive.  Anyways i'm just interested in if
> > that's the case or not since 2GB is easy to get to these days and i had
> > heard that highmem could be avoided passed the 1GB barrier.
>
> You're probably thinking of 2:2 split patches.
>
> 2:2 splits are at least technically ABI violations, which is probably
> why this isn't merged etc. Applications sensitive to it are uncommon.
>
> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
> top of the process address space.
>
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
