Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262556AbRENXAq>; Mon, 14 May 2001 19:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262562AbRENXAg>; Mon, 14 May 2001 19:00:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1960 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262556AbRENXAX>;
	Mon, 14 May 2001 19:00:23 -0400
Date: Mon, 14 May 2001 19:00:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B006229.EA65A868@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105141856090.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, H. Peter Anvin wrote:

> > LILO uses BIOS, for fsck sake. It couldn't care less for device numbers
> > on the kernel side. Ask Andries how much do they have in common with
> > BIOS drive numbers.
> > 
> 
> That's not the issue.  LILO takes whatever you pass to root= and converts
> it to a device number at /sbin/lilo time.  An idiotic practice on the
> part of LILO, in my opinion, that ought to have been fixed a long time
> ago.

Oh, _that_ one. <shrug> pass rootname=driver!name (or whatever syntax
you prefer) to the kernel and call do_mount() instead of sys_mknod() in
prepare_namespace() (rootfs patch). BFD.

