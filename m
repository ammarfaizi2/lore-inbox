Return-Path: <linux-kernel-owner+w=401wt.eu-S1751883AbXAVPBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbXAVPBk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXAVPBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:01:40 -0500
Received: from lucidpixels.com ([66.45.37.187]:35023 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbXAVPBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:01:38 -0500
Date: Mon, 22 Jan 2007 10:01:37 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Steve Cousins <steve.cousins@maine.edu>
cc: kyle <kylewong@southa.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: change strip_cache_size freeze the whole raid
In-Reply-To: <45B4D0ED.7030500@maine.edu>
Message-ID: <Pine.LNX.4.64.0701221000330.1711@p34.internal.lan>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f>
 <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan> <45B4D0ED.7030500@maine.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2007, Steve Cousins wrote:

> 
> 
> Justin Piszcz wrote:
> > Yes, I noticed this bug too, if you change it too many times or change it at
> > the 'wrong' time, it hangs up when you echo numbr > /proc/stripe_cache_size.
> > 
> > Basically don't run it more than once and don't run it at the 'wrong' time
> > and it works.  Not sure where the bug lies, but yeah I've seen that on 3
> > different machines!
> 
> Can you tell us when the "right" time is or maybe what the "wrong" time is?
> Also, is this kernel specific?  Does it (increasing stripe_cache_size) work
> with RAID6 too?
> 
> Thanks,
> 
> Steve
> -- 
> ______________________________________________________________________
>  Steve Cousins, Ocean Modeling Group    Email: cousins@umit.maine.edu
>  Marine Sciences, 452 Aubert Hall       http://rocky.umeoce.maine.edu
>  Univ. of Maine, Orono, ME 04469        Phone: (207) 581-4302
> 
> 
> 

The wrong time (for me anyway) is when/or around the time in which kernel 
is auto-detecting arrays/udev starts, when I put it there I get OOPSES all 
over the screen and it gets really nasty.  Basically the best time appears 
to be right after the system has started up but I/O hasn't started hitting 
the array yet.  Tricky, I know.

Justin.

