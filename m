Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTCEVC6>; Wed, 5 Mar 2003 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTCEVC6>; Wed, 5 Mar 2003 16:02:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18383 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264688AbTCEVC5>;
	Wed, 5 Mar 2003 16:02:57 -0500
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: High Mem Options 
In-reply-to: Your message of Wed, 05 Mar 2003 12:58:49 PST.
             <20030305205849.GU1195@holomorphy.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11772.1046898685.1@us.ibm.com>
Date: Wed, 05 Mar 2003 13:11:25 -0800
Message-Id: <E18qgAh-00033w-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Mar 2003 12:58:49 PST, William Lee Irwin III wrote:
> On Wed, 05 Mar 2003 04:26:54 PST, William Lee Irwin III wrote:
> >> Yes, the additional level of pagetables slows things down quite a bit.
> 
> On Wed, Mar 05, 2003 at 12:31:03PM -0800, Gerrit Huizenga wrote:
> > Bill, do you hvae measures for this?  I seem to remember PTX's impact
> > of PAE36 as being about 3-5% depending on workload.  Janet did one test
> > sometime back with DB2 that showed a net of no difference on TPC-H (PAE
> > slows things down, less memory pressure speeds things up) but Badari
> > just repeated with 2.5.62 or 2.5.63 and saw a larger degradation.
> > I'm wondering if some hardware is not getting correctly configured at
> > boot with with respect to MTRR's, perhaps...  I really wouldn't expect
> > a 10% impact from PAE and I don't have any consistent Linux measurements
> > to validate or invalidate that much impact.
> 
> Unfortunately the number of ca. 10% I got from you. I think badari's
> done some $BENCHMARK_THAT_CANNOT_BE_NAMED things recently that were
> consistent with the handwavy estimate but AIUI they were not intended
> to measure the effect etc. etc.

Ah, if you are referring to a number from me, that was with 2.4 and
that number seemed high to me at the time.  I don't believe that 10%
*should* be the amount of degradation.  But I don't have current numbers
(that I can share, anyway ;-) that prove anything less than that.

I expect that we'll be diving into this more over the next few months
as we can generate some large workloads and find the cause of the
degradation (and hopefully minimize it).

gerrit
