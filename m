Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSAIV5s>; Wed, 9 Jan 2002 16:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289038AbSAIV5j>; Wed, 9 Jan 2002 16:57:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:33150 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289037AbSAIV5f>; Wed, 9 Jan 2002 16:57:35 -0500
Date: Wed, 9 Jan 2002 23:57:22 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020109235722.L1200@niksula.cs.hut.fi>
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi> <20020109144549.L1331@niksula.cs.hut.fi>, <20020109144549.L1331@niksula.cs.hut.fi>; <20020109172604.N1331@niksula.cs.hut.fi> <3C3CAF85.8BD5E2E1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3CAF85.8BD5E2E1@zip.com.au>; from akpm@zip.com.au on Wed, Jan 09, 2002 at 01:00:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 01:00:53PM -0800, you [Andrew Morton] claimed:
> Ville Herva wrote:
> > 
> > >>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====
> 
> Looks like a corrupted `next' pointer in the page's buffer_head
> ring.  Your report is identical to Todd Eigenschink's repeatable
> oops.  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0689.html
> 
> In another thread, yesterday, we were discussing the elusive
> "end_request: buffer-list destroyed" crash.

(...)
 
> There were VM changes, and a messy, complex and undocumented change to
> sync_page_buffers(), which was the point at which I ceased to understand
> that function.

Nice, yet one more variable to the equation ;). And I thought I could rule
out kernel bugs by reproducing this on supposedly stable kernel (the 2.2.20
I used had all sort of patches in it; ide, e2compr and raid to name the
largest ones.)

This could be a sync_page_buffers() bug, but what puzzles me is that I can
reproduce the oopses on 2.2 as well (although they can of course be
different oopses). 

Also, I'm seeing ide and network corruption that would very much point to
pci transfer corruption. Of course, it can be that the oopses are not caused
by that.

> It could just be some random memory scribbler.  Dunno yet.  It's awfully
> repeatable.

Yep.


-- v --

v@iki.fi
