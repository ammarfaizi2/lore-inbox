Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269757AbUICSio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269757AbUICSio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUICSig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:38:36 -0400
Received: from mail3.utc.com ([192.249.46.192]:1240 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269750AbUICShR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:37:17 -0400
Message-ID: <4138B99D.2030309@cybsft.com>
Date: Fri, 03 Sep 2004 13:36:13 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com> <20040903181710.GA10217@elte.hu>
In-Reply-To: <20040903181710.GA10217@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Managed to hang the system again under heavy load. This time with the
>>above patch:
>>
>>http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-R0.txt
>>
>>Last time was with Q7:
>>
>>http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-Q7.txt
> 
> 
> seems to be the same thing - an unbalanced preemption count, possibly
> due to some locking error. Unfortunately the assert catches the
> imbalance only at exit time. (it's unlikely that the do_exit() code is
> buggy.)
> 
> i'll add a new feature to debug this: when crashing on an assert and
> tracing is enabled the trace leading up to the crash will be printed to
> the console. How did you capture the crash - was it in the syslog or do
> you have serial logging? Maybe this is not the real crash but only a
> followup crash?
> 
> 	Ingo
> 

This actually came from syslog. When it happened it was completely 
locked, so I have no idea if there was more that didn't make it to disk. 
Of course the monitor was blanked because most of the access is via the 
network. I could probably enable serial logging if necessary because 
it's sitting next to a couple of other machines.

kr
