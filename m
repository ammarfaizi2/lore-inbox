Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJIRGz>; Wed, 9 Oct 2002 13:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJIRGz>; Wed, 9 Oct 2002 13:06:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12559 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261853AbSJIRGh>; Wed, 9 Oct 2002 13:06:37 -0400
Date: Wed, 9 Oct 2002 10:14:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210090929220.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091010360.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Patrick Mochel wrote:
> 
> No problem; I'll do that today. But, I also think some of the stuff in 
> fs/partitions/check.c is bogus and should die. Partitions are not devices, 
> and shouldn't be treated as such. 

I think that is a valid argument as long as it's called "driverfs" or
something, but since the thing is clearly evolving into a "kernelfs"  and
has drivers and devices as only a part of its structure knowledge, and is
used to expose various kernel hierarchies and relationships, I actually
think that it makes sense to expose the relationship of partitions to
devices.

(Not that it has to use "struct device" to do so, of course, although I 
don't see any major reason why it couldn't..)

What's the oops due to?

		Linus

