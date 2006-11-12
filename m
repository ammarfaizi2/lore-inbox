Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932933AbWKLPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWKLPVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWKLPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:21:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41736 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932933AbWKLPVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:21:49 -0500
Date: Sun, 12 Nov 2006 16:21:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112152154.GA3382@stusta.de>
References: <20061111100038.6277efd4.akpm@osdl.org> <1163268603.3293.45.camel@laptopd505.fenrus.org> <20061111101942.5f3f2537.akpm@osdl.org> <1163332237.3293.100.camel@laptopd505.fenrus.org> <20061112125357.GH25057@stusta.de> <1163337376.3293.120.camel@laptopd505.fenrus.org> <20061112133759.GK25057@stusta.de> <1163339868.3293.126.camel@laptopd505.fenrus.org> <20061112141016.GA5297@stusta.de> <1163340998.3293.131.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163340998.3293.131.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 03:16:38PM +0100, Arjan van de Ven wrote:
> 
> > > We KNOW it can't work on a sizable amount of machines.  This is why it
> > > is a config option; you can enable it if YOUR machine is KNOWN to work,
> > > and you get some gains. But it's also understood that it often it won't
> > > work. So any sensible distro (since they have to aim for a wide
> > > audience) disables this option ...
> > 
> > Nowadays, many distributions only ship CONFIG_SMP=y kernels...
> 
> that's a calculated risk on their side (and they know that); they're
> balancing not functioning on a set of machines off against needing more
> kernels.

This might soon affect the majority of Linux users, so it's a case that 
has to be handled...

> > You miss my point.
> > 
> > You said you'd suspect it to be turned off automatic most of the time, 
> > and that's the point I think you might be wrong at.
> 
> it won't be turned off on machines that support dual core processors
> etc, since those DO get validated and designed for APIC use.. even if
> you only stick a single core processor in. So yes you're right, that
> nowadays is a pretty large group. But it's the safe group I guess:)

But if APIC is even used on my more than 1 year old 40 Euro Socket A 
board (AFAIK there have never been dual core Socket A processors, there 
were no Socket A hyperthreading CPUs, it's not an SMP board, and the
VIA KT600 is not an SMP chipset) it's not in what you call "safe group",
and I don't see any reason why my board should behave different in this 
respect from all of the millions of other UP Socket A boards.

Googling show that it could be that your claim "APIC on true UP (no 
Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft 
doesn't use it)" earlier in this thread was wrong. Looking at e.g. [1], 
it seems Windows does use the APIC even on UP.

cu
Adrian

[1] http://www.microsoft.com/whdc/system/sysperf/IO-APIC.mspx

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

