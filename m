Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWBHC2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWBHC2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWBHC2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:28:44 -0500
Received: from kanga.kvack.org ([66.96.29.28]:32183 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030455AbWBHC2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:28:44 -0500
Date: Tue, 7 Feb 2006 21:24:11 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Grant Coady <gcoady@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Message-ID: <20060208022411.GD14748@kvack.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:11:49PM +1100, Grant Coady wrote:
> This console sluggishness is noticeable enough on older hardware for me to 
> forgo exercising 2.6.latest.stable bugs for much time on it ;)
> 
> For those suffering deja vu, yes, I reported this last month (or, recently).

This bug report is a bit vague in terms of what the problem is -- the 
test case hits 3 major subsystems (io, vm, net), all of which have changed 
rather substantially in the course of 2.6 development.  Would it be possible 
to profile the system using oprofile to get an idea what the hotspots are?  
Have you compared basic hard disk throughput with hdparm, as well as 
ensuring DMA is enabled with 32 bit io?  What about testing network 
performance with netperf (or a netcat of /dev/zero)?  A few more data points 
would be quite helpful.  Cheers,

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
