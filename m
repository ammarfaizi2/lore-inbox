Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285412AbRLGSqt>; Fri, 7 Dec 2001 13:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbRLGSqg>; Fri, 7 Dec 2001 13:46:36 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:50098 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S284334AbRLGSpm>; Fri, 7 Dec 2001 13:45:42 -0500
Message-Id: <200112071845.fB7IjrE12359@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: John Alvord <jalvo@mbay.net>
Subject: Re: knfsd and memory usage
Date: Fri, 7 Dec 2001 13:45:39 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112071645.fB7GjLE03441@demai05.mw.mediaone.net> <g9221uo980sheg1uv6bc0fgjkegnldd522@4ax.com>
In-Reply-To: <g9221uo980sheg1uv6bc0fgjkegnldd522@4ax.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not under any kind of VM pressure, but I was curious since our squid 
servers have a huge cache size.  A difference between mmap and 
fopen/fread, I assume?

Is there a way to determine how much memory is going toward page-cache?  
Maybe it doesn't matter that much.  I'm just into stats.

	-- Brian

On Friday 07 December 2001 01:25 pm, you wrote:
> The non-obvious memory usage is a big disk cache. Free memory is
> wasted memory seems to be the philosophy. Theoretically, the disk
> cache memory should be able to be discared when needed, but that
> aspect seems to be a problem in some environments.
>
> john
>
>
> On Fri, 7 Dec 2001 11:45:07 -0500, Brian <hiryuu@envisiongames.net>
>
> wrote:
> >So I have this new file server (2.4.16), and it's memory looks like
> >Mem:    771952K total,   767492K used,     4460K free,    22016K
> > buffers Swap:        0K total,        0K used,        0K free,   
> > 71848K cached
> >
> >So cache, buffers, and free memory account for ~100MB.
> >There are a handful of userspace processes taking ~20MB.
> >
> >Obviously I expect the kernel to take up some memory, but 650 megs?
> >
> >Is there I way I can find out where all of that memory went?
> >If knfsd is hoarding (no other box has this much unaccounted for), is
> >there a way to tweak it at runtime?  Are there 'safe' things to adjust
> > at compile time?
> >
> >Thanks
> >	-- Brian
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
