Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRASHre>; Fri, 19 Jan 2001 02:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131082AbRASHrZ>; Fri, 19 Jan 2001 02:47:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2055 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130860AbRASHrJ>; Fri, 19 Jan 2001 02:47:09 -0500
Date: Fri, 19 Jan 2001 03:57:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pre5 VM feedback..
In-Reply-To: <Pine.LNX.4.21.0101190345210.5038-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101190356070.5038-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Marcelo Tosatti wrote:

> The swapin readahead code tries to allocate (1 << page_cluster) pages at
> each swapin. 
> 
> This means there's a big chance of having (1 << page_cluster)
> "self-swap-out"'s at each swapin if we're under low memory.
> 
> Nasty. 

Actually its even more nasty if we keep failing in refill_inactive_scan()

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
