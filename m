Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264564AbUD1BOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264564AbUD1BOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUD1BOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:14:37 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:26050 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264564AbUD1BOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:14:34 -0400
In-Reply-To: <20040428002516.GC3272@zax>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <20040428002516.GC3272@zax>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <677BC9FC-98B1-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 21:14:32 -0400
To: David Gibson <david@gibson.dropbear.id.au>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

On Apr 27, 2004, at 8:25 PM, David Gibson wrote:

> On Tue, Apr 27, 2004 at 08:02:03PM -0400, Marc Boucher wrote:
>>
>> Rusty, the workaround was done a while ago, back in the 2.5 days
>> when your new module code was still very much in flux. It was
>> necessary to have an effective short-term solution for the existing
>> installed base (2.4), since we could not continue to confuse
>> customers while waiting for the patch to propagate. In other cases,
>> we have gladly submitted patches when we encountered bugs and could
>> fix them. Had we known that the module fix was so simple, it would
>> of course have been submitted it to you in parallel.
>
> No, it wasn't *necessary*:  you made a choice that not confusing your
> customers was more important to you than not increasing the support
> burden on kernel developers by releasing a silently tainted module
> into the wild.

In an enterprise, customers always come first. Nonetheless, I don't
believe that this issue had a significant impact on kernel developers.
Had their support burden been significantly increased by our products,
the issue would have come up much sooner.

>
> That might make sense from your business perspective, but you must
> accept its consequences: anger from those you've inconvenienced for
> your benefit.  There's no reason they should give a fuck if your
> customers are confused or not.


It's not only "my" customers, but more importantly Linux users at large.
Conexant modem chipsets are extremely common hardware devices
that need to be properly supported within the constraints that we are 
facing.

Futile attempts to perform license checks generating redundant and
confusing errors, restricting access to kernel APIs for religious 
reasons,
and the general lack of stable APIs and pragmatic understanding for the
needs of third-party driver suppliers result in much greater everyday
inconveniences  to ordinary users and are more damaging to the 
acceptance
of linux than the theoretical inconvenience our workaround might have
caused to kernel developers.


>
>> Also since you and I have worked well together in other projects
>> (netfilter core) and are long time friends, I don't understand why
>> you are so quick to question my integrity in public. We didn't lie
>> about anything; the license text is perfectly clear,
>
> No, it's only clear if someone looks at the module's source (what's
> available of it), in which case the license would presumably be clear
> from comments or documentation anyway.  The main purpose of the
> MODULE_LICENSE() macro is to label the *module binary* with the
> license.  To the standard tools that look at it there, it says "GPL"
> which is clearly misleading.

No need to even look at the source; this information is clearly 
provided in the
LICENSE (which is also displayed on our website before downloading),
in the README file, and possibly other places too.

If the "standard tools" were more properly designed, such workarounds
would be totally unnecessary, and we would much rather avoid them.

Cordially
Marc

>
>> and the
>> political situation with Conexant's proprietary signal processing
>> code outside of our control.
>
> -- 
> David Gibson			| For every complex problem there is a
> david AT gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
>

