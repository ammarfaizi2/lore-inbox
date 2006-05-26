Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWEZLSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWEZLSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWEZLSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:18:07 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:43707 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932234AbWEZLSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:18:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
Date: Fri, 26 May 2006 21:17:41 +1000
User-Agent: KMail/1.9.1
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <200605262048.53131.kernel@kolivas.org> <1148642155.7602.19.camel@homer>
In-Reply-To: <1148642155.7602.19.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605262117.41806.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 21:15, Mike Galbraith wrote:
> On Fri, 2006-05-26 at 20:48 +1000, Con Kolivas wrote:
> > On Friday 26 May 2006 14:20, Peter Williams wrote:
> > > 3. Enforcement of caps is not as strict as it could be in order to
> > > reduce the possibility of a task being starved of CPU while holding
> > > an important system resource with resultant overall performance
> > > degradation.  In effect, all runnable capped tasks will get some amount
> > > of CPU access every active/expired swap cycle.  This will be most
> > > apparent for small or zero soft caps.
> >
> > The array swap happens very frequently if there are nothing but heavily
> > cpu bound tasks, which is not an infrequent workload. I doubt the zero
> > caps are very effective in that environment.
>
> Hmm.  I think that came out kinda back-assward.  You meant "the array
> swap happens very frequently _unless_..."  No?

No I didn't. If all you are doing is compiling code then the array swap will 
happen often as they will always use up their full timeslice and expire. 
Therefore an array swap will follow shortly afterwards.

> But anyway, I can't think of any reason to hold back an uncontested
> resource.

If you are compiling applications it's a contested resource.

-- 
-ck
