Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVG1UOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVG1UOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVG1UMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:12:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53419 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261777AbVG1UMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:12:21 -0400
Message-ID: <42E93CC5.5060001@watson.ibm.com>
Date: Thu, 28 Jul 2005 16:15:01 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: mbligh@mbligh.org, matthltc@us.ibm.com, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
References: <20050715013653.36006990.akpm@osdl.org>	<20050715150034.GA6192@infradead.org>	<20050715131610.25c25c15.akpm@osdl.org>	<20050717082000.349b391f.pj@sgi.com>	<1121985448.5242.90.camel@stark>	<20050721163227.661a5169.pj@sgi.com>	<42E03DD2.6020308@mbligh.org>	<20050721204631.1fb4d9a5.pj@sgi.com>	<42E070F9.6010009@watson.ibm.com> <20050722125335.10b3ee0b.pj@sgi.com>
In-Reply-To: <20050722125335.10b3ee0b.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:

Sorry for the late response - I just saw this note.

> Shailabh wrote:
> 
>>So if the current CPU controller 
>>  implementation is considered too intrusive/unacceptable, it can be 
>>reworked or (and we certainly hope not) even rejected in perpetuity. 
> 
> 
> It is certainly reasonable that you would hope such.
> 
> But this hypothetical possibility concerns me a little.  Where would
> that leave CKRM, if it was in the mainline kernel, but there was no CPU
> controller in the mainline kernel?  

It would be unfortunate indeed since CPU is the first resource that 
people want to try and control.

However, I feel the following are also true:

1. It is still better to have CKRM with the I/O, memory, network, 
forkrate controllers than to have nothing just because the CPU 
controller is unacceptable. Each controller is useful in its own right. 
It may not be enough to justify the framework all by itself but together 
with others (and the possibility of future controllers and per-class 
metrics), it is sufficient.

2. A CPU controller which is acceptable can be developed. It may not 
work as well because of the need to keep it simple and not affect the 
non-CKRM user path, but it will be better than not having anything. 
Years ago, people said a low-overhead SMP scheduler couldn't be written 
and they were proved wrong. Currently Ingo is hard at work to make 
acceptable-impact real time scheduling happen. So why should we rule out 
the possibility of someone being able to develop a CKRM CPU controller 
with acceptable impact ?

Basically, I'm pointing out that there is no reason to hold the 
acceptance of the CKRM framework + other controller's hostage to its 
current CPU controller implementation (or any one controller's 
implementation for that matter).


> Wouldn't that be a rather serious
> problem for many users of CKRM if they wanted to work on mainline
> kernels?

Yes it would. And one could say that its one of the features of the 
Linux kernel community that they would have to learn to accept. Just 
like the embedded folks who were rooting for realtime enhancements to be 
made mainstream for years now, like the RAS folks who have been making a 
case for better dump/probe tools, and you, who's tried in the past to 
get the community to accept PAGG/CSA :-)

But I don't think we need to be resigned to a CPU controller-less 
existence quite yet.  Using the examples given earlier, realtime is 
being discussed seriously now and RAS features are getting acceptance. 
So why should one rule out the possibility of an acceptable CPU 
controller for CKRM being developed ?

We, the current developers of CKRM, hope our current design can be a 
basis for the "one controller to rule them all" ! But if there are other 
ways of doing it or people can point out whats wrong with the 
implementation, it can be reworked or rewritten from scratch.

The important thing, as Andrew said, is to get real feedback about what 
is unacceptable in the current implementation and any ideas on how it 
can be done better. But lets start off with what has been put out there 
in -mm rather than getting stuck on discussing something that hasn't 
been even put out yet ?


--Shailabh



