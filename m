Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUEXSco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUEXSco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEXSco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:32:44 -0400
Received: from outbound3.mail.tds.net ([216.170.230.93]:58275 "EHLO
	outbound3.mail.tds.net") by vger.kernel.org with ESMTP
	id S264358AbUEXScj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:32:39 -0400
Date: Mon, 24 May 2004 14:31:56 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@cerberus.oppresses.us
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, rock-user@rocklinux.org
Subject: Re: Distributions vs kernel development
In-Reply-To: <200405192059.47056.rob@landley.net>
Message-ID: <Pine.LNX.4.58.0405241409460.5161@cerberus.oppresses.us>
References: <409BB334.7080305@pobox.com> <200405121412.00068.rob@landley.net>
 <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
 <200405192059.47056.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, Rob Landley wrote:

> 
> It's not really a distro.  It's an enormous HOWTO.  (Then again, so's Gentoo, 
> but gentoo does claim to be a distro, which is where I get disappointed...)
> 

No less a distribution than, say, Debian. You just type 'emerge' rather 
than 'apt-get' and get source tarballs rather than binary packages.

> 
> And then there's gentoo, which has a python script talk to a server out on the 
> net to figure out what to build.  If you're going to even TRIGGER that, you 
> need to be familiar with their packaging tool.  To take it apart and modify 
> the build would take a lot of eyeballing.
> 

Not quite; ebuilds are all on-disk. The only time you talk to a server is 
to update the on-disk ebuild tree (via rsync) or download a source 
tarball. Pretty much the same way BSD ports works. Taking apart and 
modifying the build is pretty trivial thanks to the ebuild(1) tool and the 
fact that ebuilds are in bash with Portage extensions.

> 
> Suppose they don't select OpenSSL because they go "this is a desktop system, 
> not a server", and then they realise later "oh, I need https:// support in 
> Konqueror/Mozilla"...
> 

Gentoo solves this problem with USE flags by providing a reasonable 
default set and letting users fine-tune the support they want prior to 
building the system.

> 
> You keep saying that installing from source is better, but it seems to be from 
> "gee, wouldn't it be nice if" land rather than due to actual experience.  You 
> _can_ build and install an SRPM into a Red Hat system.  It's too much of a 
> pain to be worth it to me, but it's been an option for years and years.
> 

The advantage, in my view, of compiling from source consistently is that 
you (a) eliminate any potential bugs from the build system being 
drastically different from the target system and (b) have the flexibility 
of being able to fine-tune dependencies and build time configuration. 
Where's the RPM package for Mozilla with encryption, without debugging, 
with gtk2, with ipv6, without ldap, without the calendar, with mail, 
without IRC, and without XFT? How about GCC with gcj, without f77, without 
nls, with objc?

It's certainly not for everybody, but to me that's the most important 
aspect of always compiling from source.
