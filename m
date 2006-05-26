Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWEZAY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWEZAY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWEZAY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:24:56 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:11400 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932182AbWEZAY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:24:56 -0400
Message-ID: <348603091.02442@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 08:24:51 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: + radixtree-look-aside-cache.patch added to -mm tree
Message-ID: <20060526002451.GA5973@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
	linux-kernel@vger.kernel.org
References: <200605242345.k4ONjqnE004454@shell0.pdx.osdl.net> <44753E0F.1020508@yahoo.com.au> <20060524223130.22519945.akpm@osdl.org> <44754378.7070504@yahoo.com.au> <348543696.07044@ustc.edu.cn> <44757871.4030807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44757871.4030807@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 07:27:13PM +1000, Nick Piggin wrote:
> Wu Fengguang wrote:
> 
> >
> >>Ah, I'm just having a little dig ;) (as you do with me when I break the
> >>radix-tree). No, it's great to see you're picking up the readahead stuff,
> >>however I guess one has to be fairly careful with the radix-tree though...
> >>
> >
> >I had a feeling that there were too few reviews, and with this
> >feeling, have been improving the code/doc/patch for easier reviews.
> >
> >Thank you very much for the comments, most of them are really valuable
> >ones. I'll answer them one by one and try to solve the problems ASAP.
> >
> 
> OK: just make sure to cc lkml (I forgot to with this thread)...

ok.

> >
> >>I wouldn't like to see you drop it all, however if Wu can come up with a
> >>patchset minus radix tree changes I think it would have a better chance.
> >>
> >
> >I feel very sorry for the collision with your patches.
> >I have been worried about it for some time.
> >Maybe it's time for us to address it in some constructive way?
> >
> 
> Well I think the direct data patches are fairly important, and are smallish
> and standalone. Ie. they'll most likely get in before any readahead stuff,
> so you'll have to look at porting patches to them.
> 
> I can help with that if/when the time comes. However, as I've said, I would
> drop them for the moment and just focus on the core readahead patchset.

Oh please keep them, I have fixed the code to work with the direct
data :)

Now I have removed the radix tree look-aside cache, and cut down the
new radix tree functions to three core ones:
        - __radix_tree_lookup_parent()
        - radix_tree_scan_hole_backward()
        - radix_tree_scan_hole()
In the hope that it be easier for you to work with.

> >>Wu: if someone does report that it causes poor CPU efficiency, that won't
> >>be cause for the patchset to be dropped: on the contrary it might provide
> >>some good evidence that the radix-tree work is needed. And then we can
> >>look at as a problem by itself.
> >>
> >
> >You are guessing right: I've been nervous about the CPU efficiency of
> >the context based method since the early stage of the patch. OMG it
> >would be great if I get this advice early ;)
> >
> 
> I guess this was the point I had been trying to get at. Maybe I wasn't
> explicit :\

;-)

Wu
