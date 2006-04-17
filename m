Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWDQNVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWDQNVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWDQNVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:21:50 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:11396 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1750855AbWDQNVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:21:50 -0400
Message-ID: <4443966B.8020802@compro.net>
Date: Mon, 17 Apr 2006 09:21:47 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT question : softirq and minimal user RT priority
References: <200601131527.00828.Serge.Noiraud@bull.net> <1137167600.7241.22.camel@localhost.localdomain>
In-Reply-To: <1137167600.7241.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>> Is the smallest usable real-time priority greater than the highest real-time softirq ?
> 
> Nope, you can use any rt priority you want.  It's up to you whether you
> want to preempt the softirqs or not. Be careful, timers may be preempted
> from delivering signals to high priority processes.  I have a patch to
> fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
> 
> -- Steve

I know this is an old thread but I seem to be having a problem similar
to this and I didn't find any real resolution in the archives.

I'm using the rt16 patch on 2.6.16.5 with complete preemption. I have a
high priority rt compute bound task that isn't getting signals from a
pci cards interrupt handler. Only when I insure the rt priority of the
task is lower than the rt priority of the irq thread ([IRQ 193]) will my
task receive signals.

Is this a bug? Is the bug in my interrupt handler? Or is this expected
and acceptable?

Thanks
Mark

