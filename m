Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVFKWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFKWOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 18:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFKWOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 18:14:33 -0400
Received: from soufre.accelance.net ([213.162.48.15]:15568 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261357AbVFKWO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 18:14:28 -0400
Message-ID: <42AB6240.3090103@xenomai.org>
Date: Sun, 12 Jun 2005 00:14:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu, ak@muc.de,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com>  <42AA812D.2060701@yahoo.com.au> <1118481315.9519.39.camel@sdietrich-xp.vilm.net> <42AAF7A7.4010406@opersys.com>
In-Reply-To: <42AAF7A7.4010406@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Sven-Thorsten Dietrich wrote:
> 
>>I am too looking forward to seeing results against the >= 07.48 RT
>>kernels incorporating Daniel's recent IRQ disable relief.
> 
> 
> Indeed, this is on our list.
> 
> 
>>I think the comparison should absolutely compare identical community
>>kernels. The comparison between two different release candidates is
>>questionable. rc2 to rc4 doesn't seem like much, after all, how much
>>code could go into a release candidate. (diff | wc -l) 
>>
>>Also, I question testing -rc code in the first place, except for
>>regression purposes. 
> 
> 
> On this issue, it has to be said that I don't think any set of test
> results will suffice on its own as a definitive benchmark. There will
> be a need for continued testing and publication of said results, which
> we hope others will take part in when we publish the framework we've put
> together.
> 
> 
>>Finally, there are other big-picture issues. How hard is it to maintain
>>the code in general? At the risk of ruffling feathers, forward-porting
>>RT code (or backporting) it a few revisions of rc's isn't too bad. 
>>
>>At Ingo's pace, we have all done some of that.
>>
>>How does that effort compare for porting ADEOS code? If several weeks of
>>work are invested in a comparison of rc2 to rc4, how much additional
>>work is needed to bring Adeos up to the base for the current RT kernel?
> 
> 
> Philippe can correct me if I'm wrong, but adeos maintenance is not that
> difficult. However, it has to be said that up until now, Philippe has been
> the main driving force behind adeos. So while he's been fairly good at
> publishing patches for as recent a kernel as possible, the manpower behind
> PREEMPT_RT is obviously larger. That, though, only requires interested
> parties to participate for it to change. Again, the adeos patch isn't
> that big.
>

Adeos is a faily simple code, only aimed at creating the "pipeline" 
abstraction, which is used to dispatch incoming events to the RT 
extension (which provides the co-scheduler) and Linux, according to 
their respective priorities. I'm going to build a stripped down version 
of the Adeos/x86 patch to only keep the core implementation of the 
interrupt pipeline and post it here asap, so that we could further 
discuss on actual code.

> 
>>In addition, I think the discrepancy between the vanilla kernel and the
>>RT kernel could be much greater, if the workload specifically, or even
>>coincidentally exercised bottlenecks.
> 
> 
> If you've got any specific test run suggestions, we'll gladly take them.
> 
> Karim


-- 

Philippe.
