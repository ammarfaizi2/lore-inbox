Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932942AbWKLQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbWKLQAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 11:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932943AbWKLQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 11:00:06 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:60692 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932942AbWKLQAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 11:00:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LkyqUhqgQE4WVrGot0uTZS1VqkD+yBUWQo6mKKVvPDjGPV+TzldpmSG7/Tf/U1SdQ/UAav93P/+y9zXQBHrUtIMm/LUPbNhmDl3Vw4BcPEZh0ItKvFicsMvE9kGUN+mKck9NRjoDcU/kfJAJrPowqvXSGLQiAeoP7lxgJ7MySSc=
From: Patrick McFarland <diablod3@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Date: Sun, 12 Nov 2006 10:59:55 -0500
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
References: <20061111100038.6277efd4.akpm@osdl.org> <1163340998.3293.131.camel@laptopd505.fenrus.org> <20061112152154.GA3382@stusta.de>
In-Reply-To: <20061112152154.GA3382@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121059.55454.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 November 2006 10:21, Adrian Bunk wrote:
> On Sun, Nov 12, 2006 at 03:16:38PM +0100, Arjan van de Ven wrote:
> > > > We KNOW it can't work on a sizable amount of machines.  This is why
> > > > it is a config option; you can enable it if YOUR machine is KNOWN to
> > > > work, and you get some gains. But it's also understood that it often
> > > > it won't work. So any sensible distro (since they have to aim for a
> > > > wide audience) disables this option ...
> > >
> > > Nowadays, many distributions only ship CONFIG_SMP=y kernels...
> >
> > that's a calculated risk on their side (and they know that); they're
> > balancing not functioning on a set of machines off against needing more
> > kernels.
>
> This might soon affect the majority of Linux users, so it's a case that
> has to be handled...

I actually agree here. Linux needs to be easier for people to use, not harder. 
Isn't there a way for bootloaders or the kernel early on figure out if the 
machine supports SMP, and if it doesnt, load a uniproc kernel instead?

> > > You miss my point.
> > >
> > > You said you'd suspect it to be turned off automatic most of the time,
> > > and that's the point I think you might be wrong at.
> >
> > it won't be turned off on machines that support dual core processors
> > etc, since those DO get validated and designed for APIC use.. even if
> > you only stick a single core processor in. So yes you're right, that
> > nowadays is a pretty large group. But it's the safe group I guess:)
>
> But if APIC is even used on my more than 1 year old 40 Euro Socket A
> board (AFAIK there have never been dual core Socket A processors, there
> were no Socket A hyperthreading CPUs, it's not an SMP board, and the
> VIA KT600 is not an SMP chipset) it's not in what you call "safe group",
> and I don't see any reason why my board should behave different in this
> respect from all of the millions of other UP Socket A boards.
>
> Googling show that it could be that your claim "APIC on true UP (no
> Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft
> doesn't use it)" earlier in this thread was wrong. Looking at e.g. [1],
> it seems Windows does use the APIC even on UP.

Socket A CPUs are also ungodly common. They're as common as slot 1/socket 370 
Pentium 3s, and, at least with my old P3 board, trying to use APIC on UP 
caused lockups. My Duron 1ghz laptop also does the same thing. (Booting 
either with noapic fixes it).

So yeah, if distros make stupid choices like these, then we're pretty screwed.

> cu
> Adrian
>
> [1] http://www.microsoft.com/whdc/system/sysperf/IO-APIC.mspx

-- 
Patrick McFarland || http://AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

