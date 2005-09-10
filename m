Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVIJQ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVIJQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVIJQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:29:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62654 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750872AbVIJQ3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:29:50 -0400
Date: Sat, 10 Sep 2005 09:29:39 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
In-Reply-To: <20050910023337.7b79db9a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509100921260.17110@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de> <20050910023337.7b79db9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Andrew Morton wrote:

> Andi Kleen <ak@suse.de> wrote:
> >
> >  Just noticed the ugly SGI /proc/*/numa_maps code got merged.

Well its ugly because you said that the fixes to make it less ugly were 
"useless". I can still submit those fixes that make numa_maps a part of 
smaps and that cleanup the way policies are displayed.

> Been in -mm for over two months.
> 
> >  I argued several times against it

Nope you argued against changing memory policies via proc. The numa_maps 
patch is displaying on which node a vma uses memory.

> > and I very deliberately didn't include
> >  a similar facility when I wrote the NUMA policy code because it's a bad
> >  idea.

Thats the idea of changing memory policies right? NBot displaying memory 
usages across nodes?

> >  - it presents lots of kernel internal information and mempolicy
> >  internals (like how many people have a page mapped) etc.
> >  to userland that shouldn't be exposed to this.

Very important information. Somewhat similar information is already 
available via smaps.

> >  - the format is very complicated and the chance of bug free
> >  userland parsers of this is near zero.

What is complicated about the format? And the basic use is to see where 
memory for it was placed. I have code here that parses the format.

> >  - there is no demonstrated application that needs it
> >  (there was a theoretical usecase where it might be needed,
> >  but there were better solutions proposed for this) 

Could you be more specific? The application is to figure out how memory is 
placed. Just to cat /proc/<pid>/numa_maps. Seems to be a favorite with 
some people.

> >  Can the patch please be removed? 
> 
> OK by me.  I queued a revert patch.

No idea why that would be necessary.
