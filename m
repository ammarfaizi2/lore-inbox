Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286247AbRLJMWb>; Mon, 10 Dec 2001 07:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286244AbRLJMWV>; Mon, 10 Dec 2001 07:22:21 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:658 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S286241AbRLJMWQ>; Mon, 10 Dec 2001 07:22:16 -0500
Date: Mon, 10 Dec 2001 12:22:15 GMT
From: ncw@axis.demon.co.uk
Message-Id: <200112101222.fBACMFC17255@irishsea.home.craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Colo[u]rs"
In-Reply-To: <1007972036.1237.36.camel@phantasy>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>  <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>   <5.1.0.14.2.20011210024959.01c81c20@whisper.qrpff.net> <1007972036.1237.36.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>  On Mon, 2001-12-10 at 03:00, Stevie O wrote:
>  
> > For the n-way associative deal:
>  
>  If the cache is n-way associative, it can store n lines at each
>  mapping.  So even though two virtual addresses map to the same cache
>  line, they can both be stored.  Of course, if you have k addresses such
>  that k>n, then you reach the same problem as direct map (the case where
>  n=1) caches.

That is a good explanation.  Related would be the TLB and its
thrashing...

>  To reiterate, the point of coloring would be to prevent the case of
>  multiple addresses mapping to the same line.

Can you get colo[u]red memory from user-space?  This would be really
useful for certain memory intensive applications (I'm thinking of
large FFT users like mprime/ARMprime here)

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk

>  Let me give you a
>  real-life example.  We recently have been trying to color the kernel
>  stack.  If every process's stack lies at the same address (let alone the
>  same page multiple and offset), then they all map to the same place in
>  the cache and we can effectively only cache one of them (and
>  subsequently cache miss on every other access).  If we "color" the
>  location of the stack, we make sure they don't all map to the same
>  place.  This obviously involves some knowledge of the cache system, but
>  it tends to be general enough that we can get it right for all cases.
>  
>  If you are _really_ interested in this, an excellent and very thorough
>  book is UNIX Systems for Modern Architectures: Symmetric Multiprocessing
>  and Caching for Kernel Programmers, by Curt Schimmel.
>  
>  	Robert Love
>  
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to 
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  


