Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVAEOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVAEOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVAEOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:38:56 -0500
Received: from relay01.pair.com ([209.68.5.15]:35855 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S262454AbVAEOis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:38:48 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41DBFBF6.10107@cybsft.com>
Date: Wed, 05 Jan 2005 08:38:46 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Real-Time Preemption, comparison to 2.6.10-mm1
References: <OFA8EC1208.C9EB05D9-ON86256F80.004C2451@raytheon.com>
In-Reply-To: <OFA8EC1208.C9EB05D9-ON86256F80.004C2451@raytheon.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@raytheon.com wrote:
>>On Tue, 2005-01-04 at 14:11 -0600, Mark_H_Johnson@raytheon.com wrote:
>>
>>>The non RT application starvation for mm1 was much less
>>>pronounced but still present. I could watch the disk light
>>>on the last two tests & see it go out (and stay out) for an
>>>extended period. It does not make sense to me that a single RT
>>>application (on a two CPU machine) and a nice'd non RT application
>>>can cause this starvation behavior. This behavior was not
>>>present on the 2.4 kernels and seems to be a regression to me.
> 
> 
>>I think I am seeing this problem too.  It doesn't just apply to RT
>>tasks, it seems that CPU bound tasks starve each other.  I noticed that
>>with the RT kernel, a kernel compile or dpkg will starve evolution, to
>>the point where it takes 30 seconds to display a message.  If I go and
>>background the CPU hog, the message renders _instantly_.
> 
> 
>>It's definitely present with 2.6.10-rc2 + RT (PK config) and absent with
>>2.6.10 vanilla.  I need to figure out whether -mm has the problem.
> 
> My point was that -mm definitely has the problem (though to a lesser
> degree). The tests I ran showed it on both the disk read and disk copy
> stress tests. I guess I should try a vanilla 2.6.10 run as well to see
> if it is something introduced in the -mm series (it certainly is not a
> recent change...).
> 
> --Mark H Johnson
>   <mailto:Mark_H_Johnson@raytheon.com>
> 
> 
I'm curious if anyone is seeing this behavior on UP systems, or is it 
only happening on SMP?

kr
