Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUDUSDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUDUSDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDUSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:03:04 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60033 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262425AbUDUSC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:02:59 -0400
Date: Wed, 21 Apr 2004 14:03:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexey Mahotkin <alexm@w-m.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: flooded by "CPU#0: Running in modulated clock mode"
In-Reply-To: <87llkpmee8.fsf@dim.w-m.ru>
Message-ID: <Pine.LNX.4.58.0404211401090.3745@montezuma.fsmlabs.com>
References: <87llkpmee8.fsf@dim.w-m.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Alexey Mahotkin wrote:

> I'm running 2.6.5, compiled for i686 architecture, on Celeron 1.8GHz.
> Motherboard is ASUS P4S800-MX.  The machine has 1U form-factor.
>
> Usually processor runs at ~40C, according to lm-sensors (and BIOS
> agrees with it).
>
> When I start CPU hog (prime-net client), the temperature rises to ~62C
> in several minutes.  After that I'm getting a swamp of messages:
>
>
>         CPU#0: Running in modulated clock mode
>         CPU#0: Temperature/speed normal
>         CPU#0: Temperature above threshold
>         CPU#0: Running in modulated clock mode
>         CPU#0: Temperature/speed normal
>         CPU#0: Temperature above threshold
>         [ ...endless... ]
>
> When I stop it, messages stop immediately, and processor cools down
> back to 40C.
>
> However, according to google, maximum Celeron temperature must be
> somewhere near 80C.  Also, AFAIU, if it were overheating, I'd get a
> single message about "Temperature above threshold".
>
> Why is it flooding me on KERN_EMERG level?  How can I change the
> temperature threshold?

I'll consider switching it to KERN_INFO or perhaps find some way of
throttling the output. The threshold is set so that its below the
catastrophic shutdown threshold. so ~60C sounds right considering your
processor will probably shutdown at 80C.

> Should I try noapic?  Should I try acpi=off?

It's actually CONFIG_X86_MCE_P4THERMAL you could always disable that, but
then you wont get notification when your processor is overheating. Is the
cooling setup in the room housing the server also adequate? You could also
try looking into better cooling solutions for the processor.
