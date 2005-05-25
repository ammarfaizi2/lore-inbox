Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVEYSAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEYSAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEYSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:00:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58350 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261495AbVEYSAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:00:21 -0400
Subject: Re: RT patch acceptance
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1br6zxm1b.fsf@muc.de>
References: <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
	 <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de>
Content-Type: text/plain
Date: Wed, 25 May 2005 11:00:19 -0700
Message-Id: <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 19:17 +0200, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > * Andrew Morton <akpm@osdl.org> wrote:
> >
> >> Sven Dietrich <sdietrich@mvista.com> wrote:
> >> >
> >> > I think people would find their system responsiveness / tunability
> >> >  goes up tremendously, if you drop just a few unimportant IRQs into
> >> >  threads.
> >> 
> >> People cannot detect the difference between 1000usec and 50usec 
> >> latencies, so they aren't going to notice any changes in 
> >> responsiveness at all.
> >
> > i agree in theory, but interestingly, people who use the -RT branch do 
> > report a smoother desktop experience. While it might also be a 
> 
> I bet if you did a double blind test (users not knowing if they
> run with RT patch or not or think they are running with patch when they
> are not) they would report the same. 
> 

I would take that bet double or nothing.

> Basically when people go through all that effort of applying
> a patch 
You mean typing "patch -p1 < ..."

> then they really want to see an improvement. If it is there
> or not.
> 

Hopefully they will also set the config options correctly :)

> You surely have seen that with other patches when users
> suddenly reported something worked better/smoother with a new
> release etc and there was absolutely no explanation for it in the changed
> code.
> 

I suppose the audio guys have something on that. 
Even if you don't have an ear for music, you can hear a 
skip on a CD, a scratch on a record, or a glitch on
a digital audio file from preemption latency.

These are all events in the same time frame, and
that is in the milliseconds....

> I have no reason to believe this is any different with all
> this RT testing. 
> 

And that's why we have been testing and benchmarking, to
produce number sets that supersede faith, belief, and 
conjecture. But ultimately, you can trust your senses,
and I think the audio / video test would allow your eyes 
to see, and your ears to hear the difference.

> -Andi (who also would prefer to not have interrupt threads, locks like
> a maze and related horribilities in the mainline kernel) 

I am definitely for breaking out an IRQ threads patch,
separate from the RT-mutex patches, even if just to
allow examination of that code without the clutter.



