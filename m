Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWDCX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWDCX1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDCX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:27:40 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:40442 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964941AbWDCX1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:27:39 -0400
Message-ID: <4431AF69.1000708@bigpond.net.au>
Date: Tue, 04 Apr 2006 09:27:37 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org, Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com>
In-Reply-To: <200604031459.51542.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 3 Apr 2006 23:27:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> 
> The default values for spa make it really easy to lock up the system.
> Is there a module to autotune these values according to cpu/mem/ctxt 
> performance?

Jake Moilanen had a genetic algorithm autotuner for Zaphod at one time 
which I believe he ported over to PlugSched (as he said he was going 
to).  However, I remove the per run queue statistics that he used to use 
some time ago and he hasn't complained so I've assumed that he's given 
up on it.  I've CC'd him on this mail so he may tell you what's happening.

I could generate a patch to gather the statistic again and make them 
available via /proc if you would like to try a user space version of 
Jake's work (his was in kernel).

Peter
PS The reason that I removed the stats gathering is that they add 
overhead which is undesirable if they're not being used so if I put them 
back it would probably be as a build configurable option.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
