Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030703AbWHILhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbWHILhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030704AbWHILhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:37:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23775 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030705AbWHILhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:37:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 13:36:16 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608091257.16663.rjw@sisk.pl> <20060809112701.GO3308@elf.ucw.cz>
In-Reply-To: <20060809112701.GO3308@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091336.17137.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:27, Pavel Machek wrote:
> > > > Introduce the memory bitmap data structure and make swsusp use in the suspend
> > > > phase.
> > > > 
> > > > The current swsusp's internal data structure is not very efficient from the
> > > > memory usage point of view, so it seems reasonable to replace it with a data
> > > > structure that will require less memory, such as a pair of bitmaps.
> > > 
> > > Well, 500 lines of code  for what... 0.25% bigger image?

BTW, that depends on the total size of RAM.  On a 1.5 GB i386 box that would
be something like 100%.

> > > I see it  enables you to do some cleanups... but could we get those
> > > cleanups without those 500 lines? :-).
> > 
> > Out of the 500 lines, something like 100 are comments and other 50 are
> > definitions of structures. ;-)
> 
> Yes, and of the 100 lines of comments, 10 are fixmes :-).

No, no, they are just notes. ;-)

> > Seriously speaking, I could do that without the bitmaps, but the code wouldn't
> > be that much shorter.  Apart from this, I would need to introduce yet another
> > type of PBEs (for storing pfns) and try not to get lost in the resulting mess.
> > 
> > Instead of doing this I prefer to add some extra code to set up a decent data
> > structure and just use it.
> 
> Okay, I guess that if we need to change the structure anyway, we may
> well use the effective structure...

That's exactly what I thought when I was writing this code. :-)

Rafael
