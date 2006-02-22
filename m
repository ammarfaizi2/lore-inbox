Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWBVRG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWBVRG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWBVRG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:06:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:33747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030282AbWBVRGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:06:25 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 18:06:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222170620.GA19733@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
	penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de,
	rml@novell.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Linus Torvalds wrote:

> Side note: if people want to, we could have other "trampolines" like that, 
> so that we could have more user-level code that gets distributed with the 
> kernel. It doesn't have to be something that gets mapped into every binary 
> either: we could - if we wanted to - have things like shared libraries or 
> helper shell scripts or whatever that we expose in /sys/shlib/ that are 
> kernel-version dependent.
> 
> Then we could perhaps change more things, just because we could change the 
> wrappers that actually use them together with the kernel.

Go for it, something like that is long overdue -- since you cannot be
bothered to fork experimental kernels as playgrounds which only merge
when the dust has settled.

Still, /sys has apparently changed in an incompatible way, too, Douglas
Gilbert was forced to update his userspace stuff because sysfs cahnged
layout. This madness of constantly breaking user space applications
needs to stop.

-- 
Matthias Andree
