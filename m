Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWIUAqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIUAqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWIUAqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:46:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:29888 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750873AbWIUAqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:46:02 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Paul Menage <menage@google.com>, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <20060920134903.fbd9fea8.pj@sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <20060920134903.fbd9fea8.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 17:45:59 -0700
Message-Id: <1158799559.6536.120.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:49 -0700, Paul Jackson wrote:

I concur with most of the comments (except as noted below)
> Paul M wrote:
> > Even if the resource control portions aren't totally compatible,
> > having two separate process container abstractions in the kernel is
> > sub-optimal
> 
> At heart, CKRM (ne Resource Groups) are (well, have been until now)
> different than cpusets.
> 
> Cpusets answers the question 'where', and Resource Groups 'how much'.
> 
> The fundamental motivation behind cpusets was to be able to enforce
> job isolation.  A job can get dedicated use of specified resources,
> -even- if it means those resources are severely underutilized by that
> job.
> 
> The fundamental motivation (Chandra or others correct me if I'm wrong)
> of Resource Groups is to improve capacity utilization while limiting
> starvation due to greedy, competing users for the same resources.
> 
> Cpusets seeks maximum isolation.  Resource Groups seeks maximum
> capacity utilization while preserving guaranteed levels of quality
> of service.
> 
> Cpusets are that wall between you and the neighbor you might not
> trust.  Resource groups are a large family of modest wealth sitting
> down to share a meal.

I am thinking hard about how to bring guarantee into this picture :).
 
> 
> It seems that cpusets can mimic memory resource groups.  I don't

I am little confused w.r.t how cpuset can mimic memory resource groups.
How can cpuset provide support for over commit.

> see how cpusets could mimic other resource groups.  But maybe I'm
> just being a dimm bulb.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


