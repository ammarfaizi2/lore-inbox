Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270027AbUJHPwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270027AbUJHPwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270054AbUJHPwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:52:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49831 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270027AbUJHPrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:47:22 -0400
Message-ID: <4166B569.60408@watson.ibm.com>
Date: Fri, 08 Oct 2004 11:42:33 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: ricklind@us.ibm.com, colpatch@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
References: <20041007015107.53d191d4.pj@sgi.com>	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>	<20041007072842.2bafc320.pj@sgi.com>	<4165A31E.4070905@watson.ibm.com> <20041008061426.6a84748c.pj@sgi.com>
In-Reply-To: <20041008061426.6a84748c.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Jackson wrote:
> First, thank-you, Hubertus, for comparing me to a puppy, rather
> than a kitten.  I am definitely a dog person, not a cat person,
> and I appreciate your considerate choice of analog.

Heeeh .. where did I compare you to a puppy? I was talking about *MY* 
puppy. And the moral of the story was that you can teach them new 
tricks. That's all. So in case you took this in any other way my sincere 
apologies.

> 
> I gather from the tone of your post yesterday that there is
> a disconnect between us - you speak with the frustration of
> someone who has been shouting into the wind and not being
> heard.

Frustration ... only in the sense that what seems to me to
be a pretty clear path to melt your functionality into CKRM.

Andrews, intial request was the challenge to see whether CKRM suffice as 
an API and with an additional controller suffices to provide the 
functionality.

> 
> I suspect that the disconnect, if such be, is not where you
> think it is:
> 
> Hubertus wrote:
> 
>>The disconnect is that you do not want to recognize that CKRM does NOT 
>>have to be systemwide. Once you open your mind to the fact that CKRM can 
>>be deployed with in a subset of disconnected resources (cpu domains)
>>and manages shares independently within that domain, I truely don't see
>>what the problem is.
> 
> 
> I have recognized for months that eventually we'd want to allow
> for cpuset-relative CKRM domains, and I'm pretty sure I've
> dropped comments to that affect one time or another here on lkml.
> 
> I suspect instead that "CKRM" is one layer more abstract than
> I am normally comfortable with.
> 
> As best as I can tell, CKRM has evolved from its origins as a
> fair share scheduler, into a framework (*) for things called by
> such names as classes and controllers.  As you may recall from
> an inconclusive thread between us on the ckrm-tech email list two
> months ago, I find those terms uncomfortably vague and abstract.
> 
> In general, frameworks are high risk business.  What they
> gain in generality, covering a wider range of situations in
> a uniform pattern, they lose in down to earth concreteness,
> leaving their users less confident of what works, and less able
> to rely on their intuitions.  The risk of serious design flaws,
> shrouded for a long time in the fog of abstraction, is higher.
> 
> The more successful frameworks, such as vfs for example,
> typically have deep roots in prior art, and a sizable population
> of journeyman and master practitioners.
> 
> CKRM is young, its roots more shallow, and the population of
> its practitioners small.
> 
>  (*) P.S. - It's more like CKRM is now the combination of
>      a virtual resource manager framework and a particular
>      instance of such (the fair shair controllers that have
>      their conceptual origins in IBM's WLM, I suspect).  If
>      numa placement controllers (aka cpusets) are going to
>      exist as well, then CKRM needs to split into (1) a
>      virtual resource manager framework (vrm), and (2) the
>      fair share stuff.  The vrm framework should be neutral
>      of either fair share or numa placement bias.

As indicated in many notes so are the usage of cpusets.
Very few people have the #cpus to even worry about this.
As Andrew said, its quite possible that the installations can maintain 
their own kernel, although
> 
> ===
> 
> 
> Putting aside for a moment my personal frustrations (which
> are after all my problem - and my dogs) I am simply unable to
> make sense yet of how deep would be the hit on the capabilities
> of cpusets, if so morphed, and I am painfully aware of the
> undetermined schedule delays and increased risks to product
> performance and even ultimate success that attend such a change.
> 
> From what my field engineers tell me, whom I've been polling
> furiously on this matter the last few days, at least in the
> markets that SGI frequents, there is very little overlap between
> system configurations which benefit from fair share resource
> management and those which benefit from numa placement resource
> management.  So, if that experience is generally applicable, we
> are at risk of marrying a helicopter and a boat, just because
> both have a motor and a hull, to the detriment of both.

I learned my lesson, no more analogies with you....

Bottom line I believe the cpusets should be first morphed into
sched_domains. The problem with large systems is the load balancing
which is highly unscalable. You can twist an turn but at the end of
the day you set cpu_affinity masks. The load balancing of the system
needs to be aware of the structure of the system.
sched_domains to me are the right approach for that not setting some
affinity masks underneath.

Assuming that will be resolved at some point and given Andrew's 
hypothetical assumption that CKRM makes it into his kernel, then
I don't see the obstacle of adopting an existing API to serve at the
API for cpusets/sched_domains.

> 
> Merging projects always has risks.  The payoff for synergies
> gained is not always greater than the cost of the inefficiencies
> and compromises introduced, and the less immediate involvement
> of the participants in the end result.
> 
> I cannot in good conscience recommend such a change.
But by self admission, you are driven by timing constraints as
your bacon is sizzling.
> 
> Keep talking.

To whom ?   :-)

-- Hubertus

