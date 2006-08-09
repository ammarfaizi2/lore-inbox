Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWHIMMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWHIMMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWHIMMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:12:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:57567 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161014AbWHIMMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:12:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 14:11:59 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608091336.17137.rjw@sisk.pl> <20060809115335.GA3747@elf.ucw.cz>
In-Reply-To: <20060809115335.GA3747@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091411.59696.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 13:53, Pavel Machek wrote:
> On Wed 2006-08-09 13:36:16, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Wednesday 09 August 2006 13:27, Pavel Machek wrote:
> > > > > > Introduce the memory bitmap data structure and make swsusp use in the suspend
> > > > > > phase.
> > > > > > 
> > > > > > The current swsusp's internal data structure is not very efficient from the
> > > > > > memory usage point of view, so it seems reasonable to replace it with a data
> > > > > > structure that will require less memory, such as a pair of bitmaps.
> > > > > 
> > > > > Well, 500 lines of code  for what... 0.25% bigger image?
> > 
> > BTW, that depends on the total size of RAM.  On a 1.5 GB i386 box that would
> > be something like 100%.
> 
> Well, well, but 99.75% of that is from 3/5 patch, and we could still
> get those 99.75% without bitmaps, right?

Yes.  I meant the total gain from all of the changes.  [The highmem one would
be quite difficult without bitmaps, I think, because the bitmaps give us the
right ordering of pages automatically.]

Rafael
