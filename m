Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271750AbRICQxx>; Mon, 3 Sep 2001 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271751AbRICQxn>; Mon, 3 Sep 2001 12:53:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36289 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271750AbRICQx0>;
	Mon, 3 Sep 2001 12:53:26 -0400
Date: Mon, 3 Sep 2001 12:53:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup in fs/super.c (do_kern_mount())
In-Reply-To: <200109031353.NAA32321@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0109031249590.24672-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Sep 2001 Andries.Brouwer@cwi.nl wrote:

>     From: Alexander Viro <viro@math.psu.edu>
> 
>     New helper function: do_kern_mount() (aka. kern_mount() donw right).
> 
>     +#define MS_NOUSER    (1<<31)
> 
> But you introduce a new, undocumented, mount flag?

"if you have that in ->s_flags - never attach it to any user-visible
mountpoint".

> On the other hand, if you think this bit is also useful from
> user space, then the use should be documented.)

See above.  No, it's not useful for userland ;-)  For internal use,
OTOH...

