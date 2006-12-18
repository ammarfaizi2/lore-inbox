Return-Path: <linux-kernel-owner+w=401wt.eu-S1753291AbWLRAnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbWLRAnr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 19:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbWLRAnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 19:43:47 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:43065 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbWLRAnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 19:43:46 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: "J.H." <warthog9@kernel.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
In-Reply-To: <20061217223730.GW10054@mea-ext.zmailer.org>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <45858B3A.5050804@oracle.com>  <20061217223730.GW10054@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 16:42:56 -0800
Message-Id: <1166402576.26330.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 00:37 +0200, Matti Aarnio wrote:
> On Sun, Dec 17, 2006 at 10:23:54AM -0800, Randy Dunlap wrote:
> > J.H. wrote:
> ...
> > >The root cause boils down to with git, gitweb and the normal mirroring
> > >on the frontend machines our basic working set no longer stays resident
> > >in memory, which is forcing more and more to actively go to disk causing
> > >a much higher I/O load.  You have the added problem that one of the
> > >frontend machines is getting hit harder than the other due to several
> > >factors: various DNS servers not round robining, people explicitly
> > >hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
> > >probably several other factors we aren't aware of.  This has caused the
> > >average load on that machine to hover around 150-200 and if for whatever
> > >reason we have to take one of the machines down the load on the
> > >remaining machine will skyrocket to 2000+.  
> 
> Relaying on DNS and clients doing round-robin load-balancing is doomed.
> 
> You really, REALLY, need external L4 load-balancer switches.
> (And installation help from somebody who really knows how to do this
> kind of services on a cluster.)

While this is a really good idea when you have systems that are all in a
single location, with a single uplink and what not - this isn't the case
with kernel.org.  Our machines are currently in three separate
facilities in the US (spanning two different states), with us working on
a fourth in Europe.

> > >Since it's apparent not everyone is aware of what we are doing, I'll
> > >mention briefly some of the bigger points.
> ...
> > >- We've cut back on the number of ftp and rsync users to the machines.
> > >Basically we are cutting back where we can in an attempt to keep the
> > >load from spiraling out of control, this helped a bit when we recently
> > >had to take one of the machines down and instead of loads spiking into
> > >the 2000+ range we peaked at about 500-600 I believe.
> 
> How about having filesystems mounted with "noatime" ?
> Or do you already do that ?

We've been doing that for over a year.

- John

