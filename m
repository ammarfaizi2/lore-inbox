Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDNCN3>; Fri, 13 Apr 2001 22:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRDNCNT>; Fri, 13 Apr 2001 22:13:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42213 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132725AbRDNCNE>;
	Fri, 13 Apr 2001 22:13:04 -0400
Date: Fri, 13 Apr 2001 22:12:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
In-Reply-To: <20010413193557.A15009@vger.timpanogas.org>
Message-ID: <Pine.GSO.4.21.0104132150200.26775-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Apr 2001, Jeff V. Merkey wrote:

> > Backup and AV software is not in the kernel, so they would
> > be unable to use the thing, exported or not. Please, don't
> > bring the strawmen.
> 
> Some NT anti-virus stuff is in-kernel, and it's there to catch people 
> writing viruses that act like device drivers.  One day, if and 

<shrug> If attacker can trick kernel into loading _any_ untrusted code,
no matter what contents it got, in ring 0 - you've lost anyway.

> when a Linux virus shows it's ugly head disguised as a kernel module, you 
> will be backpeddling on this statement, and wishing we had in 

No, I will be busy fixing the hole that allows to get untrusted code loaded.
I don't give a fsck whether it's a virus or not - if admin authorized it
it's his responsibility, if not - ability to get it into the kernel space is
a gaping hole that should be closed.

> > Use filp_open() - it's that simple.
> 
> Thanks.  This is what I needed to know.  I saw filp_open() in the 
> EXPORTS file, but was uncertain if this would be an unchanging API.  

Yes, it is. It's a kernel counterpart of open() - the only difference
is that instead of installing a reference to file into descriptor
table and returning the descriptor it returns the reference itself.
Arguments are the same as in case of open() and it's certainly there
to stay.

							Al

