Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422811AbWI2Ukj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWI2Ukj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWI2Uki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:40:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12232 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932371AbWI2Ukh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:40:37 -0400
Date: Fri, 29 Sep 2006 22:32:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060929203227.GA5051@elte.hu>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290108.15400.ak@suse.de> <20060929201449.GA32262@elte.hu> <200609292236.15330.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609292236.15330.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Friday 29 September 2006 22:14, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > > BTW I was planning to make LOCAL_APIC unconditional on i386 too like 
> > > on x86-64.
> > 
> > please dont - embedded doesnt need it most of the time.
> 
> What do you mean with not need?  Local APIC is an infinitely better 
> interface than PIC and faster. On embedded too this makes a lot of 
> sense.

it's just not present or hardware-disabled.

> And a lot of modern systems don't even work anymore without APIC 
> enabled because Windows uses it and the BIOS haven't been tested 
> without it (e.g. you often find totally broken code paths in the AML 
> for PIC mode)
> 
> The code size also isn't a good argument because the delta
> isn't that big:
> 
>    text    data     bss     dec     hex filename
> 3303894  694980  436420 4435294  43ad5e obj32-up/vmlinux
> 3266532  665732  402372 4334636  42242c obj32-up-noapic/vmlinux
> 
> ~63K.

63K???? You've got to be kidding. That's huge. That's ~10% of the 
minconfig kernel. Even 1K would be bad. We did config hacks for half a K 
win. Please ... dont cripple the i686 kernel.

	Ingo
