Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWABPSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWABPSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWABPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:18:15 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:10680 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750745AbWABPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:18:14 -0500
Date: Mon, 2 Jan 2006 10:21:37 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102152137.GI5213@kurtwerks.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20060101155710.GA5213@kurtwerks.com> <20060102110404.GA10996@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102110404.GA10996@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 12:04:04PM +0100, Ingo Molnar took 0 lines to write:
> 
> * Kurt Wall <kwallnator@gmail.com> wrote:
> 
> > After applying Arjan's noline patch (http://www.fenrus.org/noinlin), I 
> > see almost a 10% reduction in the size of .text (against 2.6.15-rc6) 
> > with no apparent errors and no reduction in functionality:
> 
> just to make sure: this was with -Os _also_ turned on, right? So what 
> you measured was the effect of Arjan's patch plus -Os, combined, 
> correct?

Yes. And it was a faulty approach. I've posted new results with the 
effects of Arjan's patch. CONFIG_CC_OPTIMIZE_FOR_SIZE was enabled for
all kernels.

> if yes you should measure the two effects in isolation, like the vmlinux 
> numbers i posted. Every patch applied and every change to .config 
> options must be measured separately, to get valid results. This doesnt 
> invalidate your raw vmlinux measurements - you simply need to add a 
> "Arjan's patch applied but no -Os turned on" number - but it does 
> invalidate your conclusion quoted above.

Quite so. I'm working on the "no -Os" case now.

Kurt
-- 
Alden's Laws:
	(1) Giving away baby clothes and furniture is the major cause
	    of pregnancy.
	(2) Always be backlit.
	(3) Sit down whenever possible.
