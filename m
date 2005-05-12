Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVELSAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVELSAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVELSAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:00:19 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:54742 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262088AbVELSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:00:13 -0400
Message-ID: <4283999F.8080609@virtuousgeek.org>
Date: Thu, 12 May 2005 10:59:59 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Tony Lindgren <tony@atomide.com>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com> <200505120928.55476.jesse.barnes@intel.com> <20050512171251.GA21656@in.ibm.com>
In-Reply-To: <20050512171251.GA21656@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>Even if we were to go for this tickless design, the fundamental question
>remains: who wakes up the (sleeping) idle CPU upon a imbalance? Does some other
>(busy) CPU wake it up (which makes the implementation complex) or the idle CPU 
>checks imbalance itself at periodic intervals (which restricts the amount of
>time a idle CPU may sleep).
>  
>
Waking it up at fork or exec time might be doable, and having a busy CPU 
wake up other CPUs wouldn't add too much complexity, would it?

>I guess George's experience in implementing tickless systems is that
>it is more of an overhead for a general purpose OS like Linux. George?
>  
>
The latest patches seem to do tick skipping rather than wholesale 
ticklessness.  Admittedly, the latter is a more invasive change, but one 
that may end up being simpler in the long run.  But maybe George did a 
design like that in the past and rejected it?

Jesse
