Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280728AbRKSVnI>; Mon, 19 Nov 2001 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKSVm6>; Mon, 19 Nov 2001 16:42:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280728AbRKSVmw>; Mon, 19 Nov 2001 16:42:52 -0500
Date: Mon, 19 Nov 2001 12:57:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] problem with grow_dev_page()/readpage()
In-Reply-To: <Pine.GSO.4.21.0111191533320.19969-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111191257230.8547-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Alexander Viro wrote:
>
> Then we'd better check that in bread() (getblk(), actually).  Works for
> me - that's even better than grow_dev_page().
>
> Notice that 2.4.15-pre6 _does_ have at least two bugs of that kind - aic7xxx
> (both old and new drivers).  They have an ioctl() that tries to guess the
> BIOS geometry.  It blindly does bread() on 1Kb buffer, which leaves MO
> disks very unhappy.  So check looks like a good idea...

Works for me.

		Linus

