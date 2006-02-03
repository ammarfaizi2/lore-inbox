Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWBCQFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWBCQFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWBCQFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:05:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750988AbWBCQFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:05:11 -0500
Date: Fri, 3 Feb 2006 11:04:43 -0500
From: Dave Jones <davej@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Michael Loftis <mloftis@wgops.com>,
       David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060203160443.GC24201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Michael Loftis <mloftis@wgops.com>,
	David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org> <20060202221023.GJ11831@redhat.com> <Pine.LNX.4.61.0602031323070.9696@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602031323070.9696@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 01:28:13PM +0100, Roman Zippel wrote:
 > Hi,
 > 
 > On Thu, 2 Feb 2006, Dave Jones wrote:
 > 
 > > -rw-r--r--    1 davej    davej        4613 Dec 15 23:31 linux-2.6-build-nonintconfig.patch
 > > 
 > > Adds a 'nonintconfig' target that behaves like oldconfig, but doesn't
 > > ask any questions (takes the default answer), and prints out a list
 > > at the end of all the options it didn't know about.
 > > (Handy when rebasing, as it means I get to add all the new options
 > >  in one swoop).
 > 
 > You also get the default answers with 'yes "" | make oldconfig', but what 
 > exactly are you doing with the list of config options?
 > What are the changes to confdata.c for?

Convenience more than anything.

It's to do with how the configs for Fedora/RHEL kernels are generated.
Rather than have a dozen separate .config files, and have to add a new
option to each of them, it's done in a 'templated' manner.

We have for eg, a config-generic, and then various config-$arch files,
which are munged together with a perl script to generate a final .config
that our build system eats for each arch it builds.

Having a list of all the new options together means that I can just cut-n-paste
that block of text into config-generic, and then drop out the ones that
should be per-arch.

I've felt it's another of those 'of little practical use to anyone not building
a Fedora/RHEL kernel' type patches that I've not bothered pushing it upstream.

		Dave

