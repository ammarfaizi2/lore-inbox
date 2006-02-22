Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWBVXp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWBVXp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWBVXp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:45:57 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:64913 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751543AbWBVXp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:45:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 00:31:40 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602220038.18054.rjw@sisk.pl> <20060222222445.GA13796@elf.ucw.cz>
In-Reply-To: <20060222222445.GA13796@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602230031.41217.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 22 February 2006 23:24, Pavel Machek wrote:
> > > It is doable - I'm doing it now, but am thinking about reverting part of the 
> > > code to use pbes again. If you're going to look at using bitmaps in place of 
> > > pbes, me changing would be a waste of time. Do you want me to hold off for a 
> > > while? (I'll happily do that, as I have far more than enough to keep me 
> > > occupied at the moment anyway).
> > 
> > Well, I'd say so. :-)
> > 
> > Frankly, I didn't think of dropping PBEs right now, but in the long run
> > that's worth considering, IMO.  The advantage of PBEs is that they are easy to
> > handle in the assembly parts, but apart from this they are a bit wasteful
> > (not very much, though).
> 
> Of course it will depend on what patch looks like, but changing
> assembly parts is hard -- you have to change all the architectures,
> and better not make any mistake.

Yes, that would be a lot of work, so it's rather a long term "vision".
I think we should try to get the pagecache stuff right first anyway.

> > The fact that we use page flags to store some suspend/resume-related
> > information is a big disadvantage in my view, and I'd like to get rid of that
> > in the future.  In principle we could use a bitmap, or rather two of them,
> > to store the same information independently of the page flags, and
> > if we use bitmaps for this purpose, we can use them also instead of
> > PBEs.
> 
> Well, we "only" use 2 bits... :-).

In my view the problem is this adds constraints that other people have to take
into account.  Not a good thing if avoidable IMHO.

Greetings,
Rafael

