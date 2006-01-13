Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWAMSpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWAMSpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWAMSpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:45:42 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:63446 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1422777AbWAMSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:45:41 -0500
Date: Fri, 13 Jan 2006 10:55:33 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060113185533.GA18301@hockin.org>
References: <1137104260.2370.85.camel@mindpipe> <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe> <20060113181631.GA15366@hockin.org> <1137175792.15108.26.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137175792.15108.26.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 01:09:51PM -0500, Lee Revell wrote:
> > Some apps/users need higher resolution and lower overhead that only rdtsc
> > can offer currently.
> 
> But obviously if the TSC gives wildly inaccurate results, it cannot be
> used no matter how low the overhead.

unless we can re-sync the TSCs often enough that apps don't notice.

> > I never tried it with pmtimer, we had HPET available.  Empirically TSC did
> > not work (and we had a simple test case to show how bad it could get).
> > HPET made that go away for users of gettimeofday().
> > 
> > We're exploring rdtsc-compatible solutions.
> > 
> 
> Since timekeeping on these machines has always been completely broken,
> shouldn't the default time source have been changed to the PM timer or
> HPET as soon as the problem was known?

If you have HPET, the kernel will prefer that.  I don't know enough about
the PMtimer overhead or resolution to say for sure.
