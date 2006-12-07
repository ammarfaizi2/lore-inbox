Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163211AbWLGTVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163211AbWLGTVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163218AbWLGTVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:21:50 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:43216 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163211AbWLGTVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:21:49 -0500
Subject: Re: additional oom-killer tuneable worth submitting?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45785DDD.3000503@nortel.com>
References: <45785DDD.3000503@nortel.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 20:21:32 +0100
Message-Id: <1165519292.14110.2.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 12:30 -0600, Chris Friesen wrote:
> The kernel currently has a way to adjust the oom-killer score via 
> /proc/<pid>/oomadj.
> 
> However, to adjust this effectively requires knowledge of the scores of 
> all the other processes on the system.
> 
> I'd like to float an idea (which we've implemented and been using for 
> some time) where the semantics are slightly different:
> 
> We add a new "oom_thresh" member to the task struct.
> We introduce a new proc entry "/proc/<pid>/oomthresh" to control it.
> 
> The "oom-thresh" value maps to the max expected memory consumption for 
> that process.  As long as a process uses less memory than the specified 
> threshold, then it is immune to the oom-killer.

You would need to specify the measure of memory used by your process;
see the (still not resolved) RSS debate.

> On an embedded platform this allows the designer to engineer the system 
> and protect critical apps based on their expected memory consumption. 
> If one of those apps goes crazy and starts chewing additional memory 
> then it becomes vulnerable to the oom killer while the other apps remain 
> protected.
> 
> If a patch for the above feature was submitted, would there be any 
> chance of getting it included?  Maybe controlled by a config option?


