Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUGCCzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUGCCzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 22:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUGCCzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 22:55:48 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:5091 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265795AbUGCCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 22:55:46 -0400
Date: Sat, 3 Jul 2004 12:54:58 +1000
From: Andrew Clausen <clausen@gnu.org>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703025457.GC630@gnu.org>
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org> <s5gzn6iz2or.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gzn6iz2or.fsf@patl=users.sf.net>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 02:45:50PM -0400, Patrick J. LoPresti wrote:
> >     2) use EDD, it does a much better job -- maybe this suggestions
> >        doesn't make much sense overall, so only 1) left if you don't 
> >        want to keep guessing.
> 
> Using EDD to deduce the geometry is the "right" answer.  But this is
> sufficiently complex and special-purpose that it has no place in the
> kernel.

You think it should be in user-space?  I don't think talking to the
BIOS should ever be in user-space.

> > > The only case I see where absolutely something is needed is the
> > > case of partitioning an empty disk.
> > 
> > Recovery, cloning, ...
> 
> ...moving a drive between machines...
> 
> Why does this stupid idea keep coming up?  Inferring the geometry from
> the existing partition table is just plain wrong.  It is even more
> wrong than the old 2.4 behavior, because it is still a guess, just a
> worse guess.

Didn't the old 2.4 behaviour include BIOS queries?

In any case, I don't have any evidence that anything is wrong.  On my
computer, I can tell the BIOS to use CHS geometry, (as opposed to
"Auto", "LBA" or "Large") modify the partition table to set the CHS
start/end of the Windows partition to 0, 1024, or anything I like, and
Windows STILL works.  I can't get anything to break!

So, can anyone break Windows?

Cheers,
Andrew

