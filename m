Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131110AbQK3BXu>; Wed, 29 Nov 2000 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131506AbQK3BXm>; Wed, 29 Nov 2000 20:23:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17897 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131110AbQK3BX1>;
        Wed, 29 Nov 2000 20:23:27 -0500
Date: Wed, 29 Nov 2000 19:52:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Randy Dunlap <randy.dunlap@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount 2x, umount 1x
In-Reply-To: <3A25A39F.3162018E@intel.com>
Message-ID: <Pine.GSO.4.21.0011291949500.17068-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Randy Dunlap wrote:

> [I reported this a couple of months back.  Got no
> feedback on it.  If it's just a DDT (don't do that)
> or a user error, please say so.]
> 
> Summary:  After I mount usbdevfs 2 times, and umount it
> 1 time, the usbcore module use count prevents it from
> being rmmod-ed.

So umount it twice. And yes, it's "don't do it, then". Every mount()
increments the use count. Every umount() decrements it. You want it
to become 0. Draw your conclusions...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
