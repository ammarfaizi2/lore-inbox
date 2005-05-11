Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVEKAMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVEKAMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVEKAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:12:35 -0400
Received: from ozlabs.org ([203.10.76.45]:26798 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261850AbVEKAIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:08:40 -0400
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
In-Reply-To: <20050511015509.B7594@banaan.localdomain>
References: <20050509232103.GA24238@suse.de>
	 <1115717357.10222.1.camel@localhost.localdomain>
	 <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru>
	 <20050510172447.GA11263@wonderland.linux.it>
	 <20050510201355.GB3226@suse.de>
	 <20050510203156.GA14979@wonderland.linux.it>
	 <20050510205239.GA3634@suse.de>
	 <20050510210823.GB15541@wonderland.linux.it>
	 <20050510232207.A7594@banaan.localdomain>
	 <20050511015509.B7594@banaan.localdomain>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:08:25 +1000
Message-Id: <1115770106.17201.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 01:55 +0200, Erik van Konijnenburg wrote:
> Hi,
> 
> Patch against module-init-tools-3.2-pre4 to ignore modules
> listed in /etc/hotplug/blacklist or blacklist.d (recursively).

That's a lot of code to make a module impossible to install, and I think
it kind of misses the point.  Surely a non-hotplug "modprobe
blacklisted-module" should work?

If we define the first install to override included install commands,
and hotplug uses --config=<blacklistfile>, I think we have a better
solution.

> * tested only with -n, -v and --showdeps, not in live use.

I'm going to start bundling the testsuite with the source, to encourage
people to actually use it: it's not that hard...

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

