Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270382AbTGWPnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTGWPnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:43:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13697 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270382AbTGWPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:43:03 -0400
Date: Wed, 23 Jul 2003 17:08:07 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307231608.h6NG87sg001012@81-2-122-30.bradfords.org.uk>
To: herbert@13thfloor.at
Subject: Re: noaltroot bootparam [was Floppy Fallback]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Trond suggested to draft a patch to address the
> > > Floppy Fallback issues (mentioned several times
> > > on lkml) by adding a kernel boot parameter, to
> > > disable the fallback, or to put it more general,
> > > to disable alternate root device attempts ...
> > >
> > > Currently the NFS-Root Floppy Fallback is the 
> > > only _user_ of such a boot parameter, but in 
> > > future, this could be used to limit multiple
> > > root situations to a make-or-brake ...
> > >
> > > please comment!
>
> Hi John!
>
> your comments are welcome,
>
> > I think the best thing to do if it's not possible to mount an
> > NFS-based root filesystem, is to wait 60 seconds, then try to contact
> > the NFS server again.
>
> I totally agree on that ...
>
> > Before the in-kernel bootloader was removed, the current behavior was
> > quite useful - it was quite possible that a hard disk-less machine
> > would boot from a floppy without using a bootloader, and mount it's
> > root filesystem from an NFS server.  In this scenario, it would be
> > impossible to boot the machine with the root on another device,
> > without modifying the boot disk, so a fallback to root on a floppy was
> > useful.
> > 
> > However, the in-kernel bootloader was removed in 2.6, so there is now
> > no reason why an alternate root couldn't simply be specified at the
> > boot prompt.
>
> hmm, sorry, obviously forgot to mention that the
> patch is for 2.4.x ...

Ah, OK, sorry, I only quickly glanced at the patch, I didn't have chance to test it.

> > If the NFS server is not accessible because of a temporary problem,
> > (too much network traffic, or it's rebooting for example), it makes
> > sense to try again after 60 seconds.
> > 
> > Not trying the floppy should become the _default_ action.
>
> this is something _I_ would prefer _too_, but on the
> other hand there is tradition, and stable, and ... ;)

I totally agree, we shouldn't change this in 2.4, because 2.4-based
distributions may rely on the existing behavior.

John.
