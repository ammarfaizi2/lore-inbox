Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTBGNfJ>; Fri, 7 Feb 2003 08:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbTBGNfJ>; Fri, 7 Feb 2003 08:35:09 -0500
Received: from unthought.net ([212.97.129.24]:56280 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S265099AbTBGNfH>;
	Fri, 7 Feb 2003 08:35:07 -0500
Date: Fri, 7 Feb 2003 14:44:46 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race in RPC code
Message-ID: <20030207134446.GB25807@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20030207123123.GA25807@unthought.net> <15939.45806.714661.655592@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15939.45806.714661.655592@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 02:21:50PM +0100, Trond Myklebust wrote:
> >>>>> " " == Jakob Oestergaard <jakob@unthought.net> writes:
> 
> 
>      > We don't know whether req has been modified between the
>      > assignment and the spin_lock.
> 
> It had better not be. If it is, then I want to know where so that we
> can fix it.
> 
> req->rq_xprt is set up when the request is initialized. It
> is not meant to change until the request gets released. This again
> should not happen while the request is still on the wait queue.
> 
> IOW the fix you propose would just be papering over another problem.

Any suggestions as to how it could happen?

The box is running huge compile jobs (>100MB memory used by each
compiler - runs 2-3 compilers concurrently) all day long - we never had
a GCC sig11 error. It has 512 MB of ECC memory (and ECC is enabled) - I
seriously doubt that we have a memory corruption problem.

The panic has happened once, just today.

I will be happy to try other solutions, but I can't verify whether they
work - I mean, if the box runs another few months without crashing that
doesn't really prove anything...

Thanks for commenting!

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
