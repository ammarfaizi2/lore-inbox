Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbSJITUh>; Wed, 9 Oct 2002 15:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJITUh>; Wed, 9 Oct 2002 15:20:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32142 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261970AbSJITUd>;
	Wed, 9 Oct 2002 15:20:33 -0400
Date: Wed, 9 Oct 2002 15:26:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091208490.14911-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091520000.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> In other words, if you think that it is reasonable to have an assocation 
> from the MD device to the list of partitions that are part of that MD 
> device, then you _need_ to have a "partition node", because otherwise you 
> cannot have the pointer to it. See?
> 
> So your "partition side" vs "filesystem side" thing doesn't matter. It 
> doesn't matter which side the associations are, you need to have a node to 
> associate _with_. 
> 
> Noth sides need a node. Even if the relationship is only going in one 
> direction.

*eeek*

Even aside of the problems with putting filesystems (and filesystem types)
into driverfs (can_unload() for each fs module?), partitions _ARE_ reused.
So logics with ->release() will be a killer.

Do you really want to do that?

