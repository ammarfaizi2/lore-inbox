Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUDUSQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUDUSQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUDUSQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:16:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:54401 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263592AbUDUSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:16:44 -0400
Date: Wed, 21 Apr 2004 14:17:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Alexey Mahotkin <alexm@w-m.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: flooded by "CPU#0: Running in modulated clock mode"
In-Reply-To: <87y8opkxyo.fsf@dim.w-m.ru>
Message-ID: <Pine.LNX.4.58.0404211411390.2250@montezuma.fsmlabs.com>
References: <8765btmd9n.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211355220.2250@montezuma.fsmlabs.com>
 <87y8opkxyo.fsf@dim.w-m.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Alexey Mahotkin wrote:

> Is that ok that the status is flapping?
>
> >>         CPU#0: Running in modulated clock mode
> >>         CPU#0: Temperature/speed normal
> >>         CPU#0: Temperature above threshold
>
> Or is it so that CPU switches to MCM, instantly cools down, switches
> to normal speed, instantly heats up and so on?

Yes it doesn't modulate indefinitely, it means that your cooling is
inadequate.

> > The threshold is set so that its below the
> > catastrophic shutdown threshold. so ~60C sounds right considering your
> > processor will probably shutdown at 80C.
>
> Who did set that threshold and how could I change it?  I'd like it to
> be ~72C, because the machine is 1U and the higher temperature is kind
> of "normal" there.

If i recall correctly it's hardware set, i'm not sure if BIOSes can modify
that these days. One thing you may want to note is that in the modulated
state the processor doesn't process interrupts and runs at a 50% clock
duty cycle. So there is a large performance loss when its running in this
mode. You really should consider looking into your cooling...
