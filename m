Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbREVR3G>; Tue, 22 May 2001 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbREVR24>; Tue, 22 May 2001 13:28:56 -0400
Received: from waste.org ([209.173.204.2]:9010 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262678AbREVR2t>;
	Tue, 22 May 2001 13:28:49 -0400
Date: Tue, 22 May 2001 12:30:13 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.GSO.4.21.0105221209130.15685-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0105221143300.19818-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, Alexander Viro wrote:

> On Tue, 22 May 2001, Oliver Xymoron wrote:
>
> > Because foo_ is a throwback to the days when C compilers had a single
> > namespace for all structure elements, not a readability aid. If you need
> > foo_ to know what type of structure you're futzing with, you need to name
> > your variables better.
>
> Not always. If the thing is used all over the tree, it'd better be
> greppable. I hate the foo->de stuff - it's not localized and it's
> impossible to grep for.

I'd like to say the compiler will happily find it for you, but the
kernel's mostly conditionally compiled..

Have you tried something like:

 find -type f | xargs grep -A100 'struct_name' | grep -e '\belement\b'

Obviously not a fix, but possibly helpful.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."



