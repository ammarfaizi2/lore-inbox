Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbSJIRiK>; Wed, 9 Oct 2002 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbSJIRiK>; Wed, 9 Oct 2002 13:38:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261968AbSJIRiI>; Wed, 9 Oct 2002 13:38:08 -0400
Date: Wed, 9 Oct 2002 10:45:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091323480.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210091042210.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Alexander Viro wrote:
> 
> It makes sense, but that should be done for gendisk.  I.e. we should have
> (name, base, range) - not a node for each partition.

Actually, we _do_ want to have a node for each partition, if we want to
show the things that are associated with one particular partition. And we
do have those things - mounts and (onc eit's working again) LVM
relationships etc.

It's a perfectly valid question to ask "what partitions are part of this 
extended disk?" or "which partition is the backing store for this 
filesystem?".  Which implies that a partition is a real first-class 
entity, not just "one of a range".

		Linus

