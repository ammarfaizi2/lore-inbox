Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTJaMiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTJaMiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:38:03 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:42208
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263285AbTJaMiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:38:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Roger Luethi <rl@hellgate.ch>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Fri, 31 Oct 2003 23:37:34 +1100
User-Agent: KMail/1.5.3
Cc: Chris Vine <chris@cvine.freeserve.co.uk>, linux-kernel@vger.kernel.org
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031031112615.GA10530@k3.hellgate.ch>
In-Reply-To: <20031031112615.GA10530@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310312337.34778.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 22:26, Roger Luethi wrote:
> On Thu, 30 Oct 2003 22:57:23 -0500, Rik van Riel wrote:
> > On Wed, 29 Oct 2003, Chris Vine wrote:
> > > However, on a low end machine (200MHz Pentium MMX uniprocessor with
> > > only 32MB of RAM and 70MB of swap) I get poor performance once
> > > extensive use is made of the swap space.
> >
> > Could you try the patch Con Kolivas posted on the 25th ?
> >
> > Subject: [PATCH] Autoregulate vm swappiness cleanup
>
> I suppose it will show some improvement but fail to get performance
> anywhere near 2.4 -- at least that's what my own tests found. I've been
> working on a break-down of where we're losing it.
> Bottom line: It's not simply a price we pay for feature X or Y. It's
> all over the map, and thus no single patch can possibly fix it.

Yes it will show improvement, and I would like to hear how much given how 
simple it is, but I agree with you. There is an intrinsic difference in the 
vm in 2.6 that makes it too hard for multiple running applications to have a 
small piece of the action instead of giving out big pieces of the action. 
While it is better in most circumstances I believe you describe well the 
problem under vm overload. I guess encoding a vm scheduler will help (and 
clearly 2.8 territory) but at what overhead cost? I have no idea myself, as 
now I'm pulling catch-phrases out of my arse that I hate hearing others use 
(see any lkml thread about scheduling from people who don't code).

Cheers,
Con

