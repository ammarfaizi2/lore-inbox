Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTF1MBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 08:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTF1MBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 08:01:05 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:59330 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265172AbTF1MBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 08:01:03 -0400
Message-Id: <5.1.0.14.2.20030628141154.00af45d0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 28 Jun 2003 14:15:38 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: 2.4.22-pre2 unresolved proc_get_inode
Cc: viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20030628112151.GC27348@parcelfarce.linux.theplanet.co.uk>
References: <5.1.0.14.2.20030628123855.00aefd18@pop.t-online.de>
 <5.1.0.14.2.20030628123855.00aefd18@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: ZkDiN4ZCweKWyp29f2YmTPN1EnuIuBm4kwUtryFerabbllQYx00s0-@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fine by me :-)
Don't use it, don't need it.
As a matter of course, I throw a standard Suse config in and answer
"m"/"y" to the new stuff. Serves to shake out a few things.

Margit

At 12:21 28.06.2003 +0100, Viro wrote:
>On Sat, Jun 28, 2003 at 12:40:36PM +0200, Margit Schubert-While wrote:
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre2; fi
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.22-pre2/kernel/drivers/net/wan/comx.o
> > depmod:         proc_get_inode
> >
> > I suppose we let Christoph and Marc fight it out.
>
>You know what?  I'm so fed up with that crap, that today Marcelo will
>get a patch killing proc_get_inode(), making proc_lookup() static and
>eliminating ->proc_iops completely.
>
>Enough is enough.  comx is the only user of that crap and all procfs
>code in comx is broken by design and trivially exploitable.  It's
>unsalvagable and any attempt to fix it will amount to rewrite from
>scratch anyway.
>
>It's not a new problem, it had been discussed to hell and back and
>comx folks could not have been arsed to do anything about it in what,
>3 years?

