Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWBVRRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWBVRRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWBVRRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:17:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:60606 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030315AbWBVRRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:17:19 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 18:17:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: sysfs regressions (was: 2.6.16-rc4: known regressions)
Message-ID: <20060222171714.GC19733@merlin.emma.line.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>
References: <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140624187.2979.38.camel@laptopd505.fenrus.org> <20060222161133.GA18059@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222161133.GA18059@infradead.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig schrieb am 2006-02-22:

> And to continue the rant: the broken mount uevent feature (which
> can't work right) got in without any serious review through the
> driver model tree.  just as all those break udev/etc patches that
> cause all these userland breakages for those people brave enough
> to use udev and surrounding bits.
> 
> Folks, we need to stop breaking sysfs interface all the time.  Having
> attributes on objects is real nice from many perspectives, but it's
> also a burden because the internal object model is now seen by the
> outside world.  That means anything involving sysfs needs a careful
> design not random patching as the driver model core people appear to
> do.

Oh, and while we're at it: perhaps someone should revert the patch that
caused Douglas Gilbert to chase incompatible sysfs changes in his
user-space applications. It's pretty sad to see random breakage,
apparently by randomly changing / to : in paths from what I discern from
Doug's Changelog. (No, I don't have the background handy, neither would
I care; I just see the application chasing sysfs changes, and that's
enough to complain.)

-- 
Matthias Andree
