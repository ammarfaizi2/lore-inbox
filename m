Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269916AbUJSTEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269916AbUJSTEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269574AbUJSTBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:01:54 -0400
Received: from poup.poupinou.org ([195.101.94.96]:49424 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S269916AbUJSSWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:22:31 -0400
Date: Tue, 19 Oct 2004 20:22:24 +0200
To: Con Kolivas <kernel@kolivas.org>
Cc: Alexander Clouter <alex-kernel@digriz.org.uk>,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041019182224.GB22405@poupinou.org>
References: <20041017222916.GA30841@inskipp.digriz.org.uk> <4172F3C5.8090604@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4172F3C5.8090604@kolivas.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 18, 2004 at 08:35:49AM +1000, Con Kolivas wrote:
> Alexander Clouter wrote:
> >>3. (major) the scaling up and down of the cpufreq is now smoother.  I 
> >>found 
> >	it really nasty that if it tripped < 20% idle time that the freq was 
> >	set to 100%.  This code smoothly increases the cpufreq as well as 
> >	doing a better job of decreasing it too
> 
> I'd much prefer it shot up to 100% or else every time the cpu usage went 
> up there'd be an obvious lag till the machine ran at it's capable speed. 
>  I very much doubt the small amount of time it spent at 100% speed with 
> the default design would decrease the battery life significantly as well.
> 

I'm almost ok with your words, but the amd64 do have unacceptable
latency between min and max freq transition, due to the step-by-step
requirements (200MHz IIRC).
Alexander's governor may be then OK for those kind of processors.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
