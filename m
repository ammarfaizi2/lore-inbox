Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270380AbTGWPSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTGWPSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:18:12 -0400
Received: from www.13thfloor.at ([212.16.59.250]:13547 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270380AbTGWPSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:18:09 -0400
Date: Wed, 23 Jul 2003 17:33:22 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: noaltroot bootparam [was Floppy Fallback]
Message-ID: <20030723153322.GA25954@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	linux-kernel@vger.kernel.org
References: <200307221904.h6MJ4Gnr001119@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200307221904.h6MJ4Gnr001119@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 08:04:16PM +0100, John Bradford wrote:
> > Trond suggested to draft a patch to address the
> > Floppy Fallback issues (mentioned several times
> > on lkml) by adding a kernel boot parameter, to
> > disable the fallback, or to put it more general,
> > to disable alternate root device attempts ...
> >
> > Currently the NFS-Root Floppy Fallback is the 
> > only _user_ of such a boot parameter, but in 
> > future, this could be used to limit multiple
> > root situations to a make-or-brake ...
> >
> > please comment!

Hi John!

your comments are welcome,

> I think the best thing to do if it's not possible to mount an
> NFS-based root filesystem, is to wait 60 seconds, then try to contact
> the NFS server again.

I totally agree on that ...

> Before the in-kernel bootloader was removed, the current behavior was
> quite useful - it was quite possible that a hard disk-less machine
> would boot from a floppy without using a bootloader, and mount it's
> root filesystem from an NFS server.  In this scenario, it would be
> impossible to boot the machine with the root on another device,
> without modifying the boot disk, so a fallback to root on a floppy was
> useful.
> 
> However, the in-kernel bootloader was removed in 2.6, so there is now
> no reason why an alternate root couldn't simply be specified at the
> boot prompt.

hmm, sorry, obviously forgot to mention that the
patch is for 2.4.x ...

> If the NFS server is not accessible because of a temporary problem,
> (too much network traffic, or it's rebooting for example), it makes
> sense to try again after 60 seconds.
> 
> Not trying the floppy should become the _default_ action.

this is something _I_ would prefer _too_, but on the
other hand there is tradition, and stable, and ... ;)

thanks,
Herbert

> John.
