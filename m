Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVLMVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVLMVQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVLMVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:16:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:23006 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932583AbVLMVQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:16:32 -0500
Subject: Re: [Lse-tech] [RFC][Patch 1/5] nanosecond timestamps and diffs
From: john stultz <johnstul@us.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
In-Reply-To: <439F1455.7080402@engr.sgi.com>
References: <43975D45.3080801@watson.ibm.com>
	 <43975E6D.9000301@watson.ibm.com>
	 <Pine.LNX.4.62.0512121049400.14868@schroedinger.engr.sgi.com>
	 <439DD01A.2060803@watson.ibm.com>
	 <1134416962.14627.7.camel@cog.beaverton.ibm.com>
	 <439F1455.7080402@engr.sgi.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 13:16:26 -0800
Message-Id: <1134508587.12313.10.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 10:35 -0800, Jay Lan wrote:
> john stultz wrote:
> > On Mon, 2005-12-12 at 19:31 +0000, Shailabh Nagar wrote:
> >>Christoph Lameter wrote:
> >>>On Wed, 7 Dec 2005, Shailabh Nagar wrote:
> >>>>+void getnstimestamp(struct timespec *ts)
> >>>
> >>>There is already getnstimeofday in the kernel.
> >>
> >>Yes, and that function is being used within the getnstimestamp() being proposed.
> >>However, John Stultz had advised that getnstimeofday could get affected by calls to
> >>settimeofday and had recommended adjusting the getnstimeofday value with wall_to_monotonic.
> >>
> >>John, could you elaborate ?
> > 
> > I think you pretty well have it covered. 
> > 
> > getnstimeofday + wall_to_monotonic should be higher-res and more
> > reliable (then TSC based sched_clock(), for example) for getting a
> > timestamp.
> 
> How is this proposed function different from
> do_posix_clock_monotonic_gettime()?
> It calls getnstimeofday(), it also adjusts with wall_to_monotinic.
> 
> It seems to me we just need to EXPORT_SYMBOL_GPL the
> do_posix_clock_monotonic_gettime()?

Indeed, this would be the same.

thanks
-john

