Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbREVThT>; Tue, 22 May 2001 15:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbREVThJ>; Tue, 22 May 2001 15:37:09 -0400
Received: from waste.org ([209.173.204.2]:31748 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262744AbREVThF>;
	Tue, 22 May 2001 15:37:05 -0400
Date: Tue, 22 May 2001 14:38:27 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Guest section DW <dwguest@win.tue.nl>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct char_device
In-Reply-To: <20010522212238.A11203@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0105221427320.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Guest section DW wrote:

> On Tue, May 22, 2001 at 11:08:16AM -0500, Oliver Xymoron wrote:
>
> > > >+       struct list_head        hash;
>
> > > Why not name consistently with the struct block_device?
> > >          struct list_head        cd_hash;
>
> > Because foo_ is a throwback to the days when C compilers had a single
> > namespace for all structure elements, not a readability aid. If you need
> > foo_ to know what type of structure you're futzing with, you need to name
> > your variables better.
>
> One often has to go through all occurrences of a variable or
> field of a struct. That is much easier with cd_hash and cd_dev
> than with hash and dev.
>
> No, it is a good habit, these prefixes, even though it is no longer
> necessary because of the C compiler.

A better habit is encapsulating your data structures well enough that the
entire kernel doesn't feel the need to go digging through them. The fact
that you have to change many widely-scattered instances of something
points to bad modularity. Supporting that practice with verbose naming is
not doing yourself a favor in the long run.

If you must, use accessor functions instead. At best you'll be able to
make sweeping semantic changes in one spot. At worst, you'll be able to
grep for it.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


