Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSGaJ3V>; Wed, 31 Jul 2002 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317875AbSGaJ3V>; Wed, 31 Jul 2002 05:29:21 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:64273 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317872AbSGaJ3U>; Wed, 31 Jul 2002 05:29:20 -0400
Date: Wed, 31 Jul 2002 11:32:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200207310032.g6V0WmW12258@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0207311109560.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 30 Jul 2002, Richard Gooch wrote:

> > Are you sure it's save in devfs_open() too?
>
> Yes. RTFS.

I'm trying - without getting headache.
In the "devfs=only" case, where is the module count incremented, when a
block device is opened?

> > Even if it's save/fixed, it's still code duplication.
>
> No. I leverage fops_get(), a common function.

Which is also insufficiently protected.
Why do you insist on storing the ops pointer in devfs? As long as devfs is
an option, that pointer must be managed at two places.

bye, Roman

