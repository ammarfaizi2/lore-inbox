Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269853AbUJHLog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269853AbUJHLog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJHLof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:44:35 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:52903 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S269861AbUJHLnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:43:05 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 8 Oct 2004 13:40:55 +0200
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410081123.45762.efocht@hpce.nec.com> <416663B7.5000901@yahoo.com.au>
In-Reply-To: <416663B7.5000901@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410081340.55083.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 11:53, Nick Piggin wrote:
> Erich Focht wrote:
> > On Thursday 07 October 2004 20:13, Martin J. Bligh wrote:
> > 
> >>It all just seems like a lot of complexity for a fairly obscure set of
> >>requirements for a very limited group of users, to be honest. Some bits
> >>(eg partitioning system resources hard in exclusive sets) would seem likely
> >>to be used by a much broader audience, and thus are rather more attractive.
> > 
> > May I translate the first sentence to: the requirements and usage
> > models described by Paul (SGI), Simon (Bull) and myself (NEC) are
> > "fairly obscure" and the group of users addressed (those mainly
> > running high performance computing (AKA HPC) applications) is "very
> > limited"? If this is what you want to say then it's you whose view is
> > very limited. Maybe I'm wrong with what you really wanted to say but I
> > remember similar arguing from your side when discussing benchmark
> > results in the context of the node affine scheduler.
> > 
> > This "very limited group of users" (small part of them listed in
> > www.top500.org) is who drives computer technology, processor design,
> > network interconnect technology forward since the 1950s.

> With all due respect, Linux gets driven as much from the bottom up
> as it does from the top down I think. Compared to desktop and small
> servers, yes you are obscure :)

I wasn't speaking of driving the Linux development, I was speaking of
driving the computer technology development. Just look at where the
DOD, DARPA, DOE money goes to. I actually aknowledged that HPC doesn't
really have a foot in the kernel developer community.

> My view on it is this, we can do *exclusive* dynamic partitioning
> today (we're very close to it - it wouldn't add complexity in the
> scheduler to support it).

Right, but that's an implementation question. The question 
  cpusets {AND, OR, XOR} CKRM ?
was basically a user space API question. I'm sure nobody will object
to changing the guts of cpusets to use sched_domains on exclusive sets
when this possibility will be there and ... simple.

> You can also hack up a fair bit of other functionality with cpu
> affinity masks.

I'm doing that for a subset of cpusets functionality in a module
(i.e. without touching the task structure and without hooking on
fork/exec) but that's ugly and on the long term insufficient.

Regards,
Erich

