Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUD3JuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUD3JuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUD3JuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:50:23 -0400
Received: from holomorphy.com ([207.189.100.168]:42624 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265135AbUD3JuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:50:20 -0400
Date: Fri, 30 Apr 2004 02:50:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: NUMA API
Message-ID: <20040430095014.GD1298@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Ulrich Drepper <drepper@redhat.com>,
	linux-kernel@vger.kernel.org
References: <409201BE.9000909@redhat.com> <20040430014933.1f1fe8a7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430014933.1f1fe8a7.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Uli wrote:
>> Please direct comments to me.  In case there is interest I can set up a
>> separate mailing list since lkml is probably not the best venue.

On Fri, Apr 30, 2004 at 01:49:33AM -0700, Paul Jackson wrote:
> Thanks for posting this.
> If not the kernel mailing list, then could you specify some other
> existing public list?  Sometimes useful feedback comes from the
> interaction of several people responding, which is less likely to
> happen if it is all funneled through one person.

The real problem with this is that f's been maintaining and bugfixing
and handling feature requests for people who are actually going to
depend on this stuff for a rather long time, and the total rewrite here
throws all that work to make things work for those who rely on the stuff
away in addition to creating a brand new vendor skew problem from scratch.

Uli likely has legitimate poihts in need of addressing. From-scratch
rewrites are not the proper ways to address them, especially not when
such a very strong precedent and various 3rd-parties' reliance on the
preexisting API's and codebases are established.

The proper methods for addressing these issues are by incrementally
improving f's codebase and fixing the bugs and/or limitations discussed
(e.g. hotplugging vs. NUMA API issues). What Uli has expressed is not a
sound basis for a ground-up, from-scratch API implementation. The issues
Uli wants to address are bugfixes and extensions, and should be
required to go through the same procedures and review as such, and these
in turn require working with the preexisting codebase, not wild from-
scratch rewrites of the known universe. Especially not with the
extremely transparent ulterior motives for incompatible API's proposed
on the day of SuSE's freeze.

I'm all in favor of the best. As the deficiencies are pointed out, I
won't rest until these are fixed and the implementation is the best.
But this proposed API divergence is not how it should be made so. Being
the best means having a coherent story, and bickering and contrived
incompatibilities betweeen distros is not how coherent stories and
customer satisfaction happen.


-- wli
