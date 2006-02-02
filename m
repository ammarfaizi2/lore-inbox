Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWBBWK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWBBWK4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBBWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:10:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25223 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932327AbWBBWKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:10:55 -0500
Date: Thu, 2 Feb 2006 17:10:25 -0500
From: Dave Jones <davej@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michael Loftis <mloftis@wgops.com>, David Weinehall <tao@acc.umu.se>,
       Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202221023.GJ11831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Michael Loftis <mloftis@wgops.com>,
	David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202220519.GA8712@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:05:19PM +0100, Sam Ravnborg wrote:
 > On Thu, Feb 02, 2006 at 03:10:08PM -0500, Dave Jones wrote:
 > > In the current FC4 2.6.15.2 based update..
 > > 
 > > - 3 convenient 'make the buildsys life easier' patches
 > Something I should have a look at?
 > A pointer would be fine.

Nothing really amazing.. (I also miscounted -- 4 patches).

-rw-r--r--    1 davej    davej        4613 Dec 15 23:31 linux-2.6-build-nonintconfig.patch

Adds a 'nonintconfig' target that behaves like oldconfig, but doesn't
ask any questions (takes the default answer), and prints out a list
at the end of all the options it didn't know about.
(Handy when rebasing, as it means I get to add all the new options
 in one swoop).

-rw-r--r--    1 davej    davej         605 Dec 15 23:31 linux-2.6-build-reference-discarded-opd.patch

Think I posted this already, and it may even be in 16rc

-rw-r--r--    1 davej    davej        1686 Dec 15 23:31 linux-2.6-build-userspace-headers-warning.patch

adds a #error to includes if __KERNEL__ isn't being used
(We want people to use the headers from our glibc-kernheaders package,
 not from the kernel soucre).

-rw-r--r--    1 davej    davej        1753 Dec 15 23:31 linux-2.6-bzimage.patch

To get around some gynamstics in the rpm spec, defining a seperate build target
for every arch, we make every arch grok 'bzImage'. Fugly, but it keeps the
spec cleaner to maintain.

		Dave

