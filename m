Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWBWIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWBWIsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWBWIsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:48:30 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:16276 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751657AbWBWIs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:48:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 09:44:25 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602230031.41217.rjw@sisk.pl> <20060222235639.GK13621@elf.ucw.cz>
In-Reply-To: <20060222235639.GK13621@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602230944.26253.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 February 2006 00:56, Pavel Machek wrote:
> > > > > It is doable - I'm doing it now, but am thinking about reverting part of the 
> > > > > code to use pbes again. If you're going to look at using bitmaps in place of 
> > > > > pbes, me changing would be a waste of time. Do you want me to hold off for a 
> > > > > while? (I'll happily do that, as I have far more than enough to keep me 
> > > > > occupied at the moment anyway).
> > > > 
> > > > Well, I'd say so. :-)
> > > > 
> > > > Frankly, I didn't think of dropping PBEs right now, but in the long run
> > > > that's worth considering, IMO.  The advantage of PBEs is that they are easy to
> > > > handle in the assembly parts, but apart from this they are a bit wasteful
> > > > (not very much, though).
> > > 
> > > Of course it will depend on what patch looks like, but changing
> > > assembly parts is hard -- you have to change all the architectures,
> > > and better not make any mistake.
> > 
> > Yes, that would be a lot of work, so it's rather a long term
> > "vision".
> 
> Ok, I have no problems with visions.
> 
> > I think we should try to get the pagecache stuff right first anyway.
> 
> Are you sure it is worth doing? I mean... it only helps on small
> machines, no?
> 
> OTOH having it for benchmarks will be nice, and perhaps we could use
> that kind it to speed up boot and similar things... 

Currently some people can't suspend with the mainline code because it cannot
free as much memory as needed on their boxes.  I think we should care for them
too.

Besides, if they could suspend, we'd have more users and more testing coverage
for device drivers, especially for devices that are no longer installed in
newer boxes. ;-)

Greetings,
Rafael
