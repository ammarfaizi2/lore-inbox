Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbSJIRmP>; Wed, 9 Oct 2002 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJIRmC>; Wed, 9 Oct 2002 13:42:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59037 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261982AbSJIRlc>;
	Wed, 9 Oct 2002 13:41:32 -0400
Date: Wed, 9 Oct 2002 13:47:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091042210.7355-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091344280.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 9 Oct 2002, Alexander Viro wrote:
> > 
> > It makes sense, but that should be done for gendisk.  I.e. we should have
> > (name, base, range) - not a node for each partition.
> 
> Actually, we _do_ want to have a node for each partition, if we want to
> show the things that are associated with one particular partition. And we
> do have those things - mounts and (onc eit's working again) LVM
> relationships etc.
> 
> It's a perfectly valid question to ask "what partitions are part of this 
> extended disk?" or "which partition is the backing store for this 
> filesystem?".  Which implies that a partition is a real first-class 
> entity, not just "one of a range".

Sorry, no.  Which partition is the backing store for this filesystem is
question to some filesystem drivers.  Not even every fs driver that
happens to use block devices - some of them use more than one (e.g
for journal).

IOW, it's not a partition property.

