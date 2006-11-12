Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWKLOKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWKLOKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 09:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWKLOKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 09:10:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59911 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932908AbWKLOKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 09:10:12 -0500
Date: Sun, 12 Nov 2006 15:10:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-ID: <20061112141016.GA5297@stusta.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org> <20061111100038.6277efd4.akpm@osdl.org> <1163268603.3293.45.camel@laptopd505.fenrus.org> <20061111101942.5f3f2537.akpm@osdl.org> <1163332237.3293.100.camel@laptopd505.fenrus.org> <20061112125357.GH25057@stusta.de> <1163337376.3293.120.camel@laptopd505.fenrus.org> <20061112133759.GK25057@stusta.de> <1163339868.3293.126.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163339868.3293.126.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 02:57:48PM +0100, Arjan van de Ven wrote:
> On Sun, 2006-11-12 at 14:37 +0100, Adrian Bunk wrote:
> > On Sun, Nov 12, 2006 at 02:16:16PM +0100, Arjan van de Ven wrote:
> > > 
> > > > Some APIC-related bugs in the kernel Bugzilla that have been reported or 
> > > > confirmed during the last 12 months (I only looked at "apic" in the 
> > > > subject, there might be more related bugs in the Bugzilla):
> > > > 
> > > > #5038 Fast running system clock with IO-APIC enabled
> > > 
> > > This is a UP machine. NotInteresting(tm) wrt APIC.
> > >... 
> > 
> > Currently it's a supported configuration.
> 
> define "supported"; we have code to try it and it's great if it works.
> But if it doesn't... you're out of luck.
> 
> We KNOW it can't work on a sizable amount of machines.  This is why it
> is a config option; you can enable it if YOUR machine is KNOWN to work,
> and you get some gains. But it's also understood that it often it won't
> work. So any sensible distro (since they have to aim for a wide
> audience) disables this option ...

Nowadays, many distributions only ship CONFIG_SMP=y kernels...

> > We must either handle such cases or explicitely disable the APIC on all 
> > UP machines 
> 
> that'd be the same as setting the config option off...

Except for the common case of CONFIG_SMP=y kernels on UP machines...

> > > I think that's a mistake. But oh well, I suspect in practice ACPI/BIOS
> > > cause it to be turned off automatic most of the time.
> > 
> > I'd doubt the latter. Even on my cheap Asus board running an i386
> > AMD Athlon XP with 1.8 GHz the APIC is both used and working without any
> > problems.
> 
> "it works on my one machine so it works for everyone". That's simply not
> true. We KNOW it can't work everywhere on UP, especially on i386. SMM
> assumptions; people gluing the apic pins to the reset line, we've seen
> it all. 
> That it works for you is great. But that doesn't mean it automatically
> works for everyone.

You miss my point.

You said you'd suspect it to be turned off automatic most of the time, 
and that's the point I think you might be wrong at.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

