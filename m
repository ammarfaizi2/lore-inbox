Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUJSTAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUJSTAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270019AbUJSSYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:24:10 -0400
Received: from mail3.utc.com ([192.249.46.192]:40153 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S270139AbUJSSGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:06:14 -0400
Message-ID: <41755774.5050306@cybsft.com>
Date: Tue, 19 Oct 2004 13:05:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
References: <OF684A90CB.5A611764-ON86256F32.005DA19F@raytheon.com> <20041019174050.GA18998@elte.hu>
In-Reply-To: <20041019174050.GA18998@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> 
>>Booted to single user and was able to get some network operations
>>going with this version (w/ previously mentioned update). However, at
>>the step where I start CUPS, I got a number of traces on the display
>>referring to parport_pc related function calls [but I don't use a
>>parallel printer...]. It ended with:
> 
> 
> thanks for the logs - there are some semaphore assumptions in
> ieee1284.c, it should use completions & wait_for_completion_timeout()
> too. The workaround is to disable CONFIG_PARPORT_1284. (or
> CONFIG_PARPORT altogether.)
> 
> 	Ingo
> 

If only he had been a little faster getting this in, I wouldn't have sat 
and written the entire screen full down on paper. :) Mine wasn't making 
it to the logs. At least he saved me from typing it all back in. Thanks 
Mark. Disabling PARPORT fixed my problem as well.

kr
