Return-Path: <linux-kernel-owner+w=401wt.eu-S1753016AbWLSGyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbWLSGyN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbWLSGyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:54:12 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:33557 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbWLSGyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:54:12 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: "J.H." <warthog9@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
In-Reply-To: <20061219063413.GI24090@1wt.eu>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <20061219063413.GI24090@1wt.eu>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 22:52:51 -0800
Message-Id: <1166511171.26330.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 07:34 +0100, Willy Tarreau wrote:
> On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
> (...)
> > Since it's apparent not everyone is aware of what we are doing, I'll
> > mention briefly some of the bigger points.
> > 
> > - We have contacted HP to see if we can get additional hardware, mind
> > you though this is a long term solution and will take time, but if our
> > request is approved it will double the number of machines kernel.org
> > runs.
> 
> Just evil suggestion, but if you contact someone else than HP, they
> might be _very_ interested in taking HP's place and providing whatever
> you need to get their name on www.kernel.org. Sun and IBM do such
> monter machines too. That would not be very kind to HP, but it might
> help getting hardware faster.

I leave the actual hardware acquisitions up to HPA, I just try to keep
the machines up and running without too many problems.  HP has been
incredibly supportive of kernel.org in the past and I for one have been
very appreciative of their hardware and would love to continue working
with them.

> 
> > - Gitweb is causing us no end of headache, there are (known to me
> > anyway) two different things happening on that.  I am looking at Jeff
> > Garzik's suggested caching mechanism as a temporary stop-gap, with an
> > eye more on doing a rather heavy re-write of gitweb itself to include
> > semi-intelligent caching.  I've already started in on the later - and I
> > just about have the caching layer put in.  But this is still at least a
> > week out before we could even remotely consider deploying it.
> 
> Couldn't we disable gitweb for as long as we don't get newer machines ?
> I've been using it in the past, but it was just a convenience. If needed,
> we can explode all the recent patches with a "git-format-patch -k -m" in a
> directory.

I've mentioned this to the other admins and the consensus was that there
would be quite the outcry to suggest this - if the consensus is to
disable gitweb until we can get it under control we would take doing
that into consideration.

> 
> > - We've cut back on the number of ftp and rsync users to the machines.
> > Basically we are cutting back where we can in an attempt to keep the
> > load from spiraling out of control, this helped a bit when we recently
> > had to take one of the machines down and instead of loads spiking into
> > the 2000+ range we peaked at about 500-600 I believe.
> 
> I did not imagine FTP and rsync being so much used !

On average we are moving anywhere from 400-600mbps between the two
machines, on release days we max both of the connections at 1gpbs each
and have seen that draw last for 48hours.  For instance when FC6 was
released in the first 12 hours or so we moved 13 TBytes of data.

> 
> > So we know the problem is there, and we are working on it - we are
> > getting e-mails about it if not daily than every other day or so.  If
> > there are suggestions we are willing to hear them - but the general
> > feeling with the admins is that we are probably hitting the biggest
> > problems already.
> 
> BTW, yesterday my 2.4 patches were not published, but I noticed that
> they were not even signed not bziped on hera. At first I simply thought
> it was related, but right now I have a doubt. Maybe the automatic script
> has been temporarily been disabled on hera too ?

The script that deals with the uploads also deals with the packaging -
so yes the problem is related.

> 
> > - John 'Warthog9' Hawley
> > Kernel.org Admin
> 
> Thanks for keeping us informed !
> Willy

Doing what I can :-)

- John

