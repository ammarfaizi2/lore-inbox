Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbREPRLz>; Wed, 16 May 2001 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262015AbREPRLg>; Wed, 16 May 2001 13:11:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262013AbREPRLd>; Wed, 16 May 2001 13:11:33 -0400
Date: Wed, 16 May 2001 10:11:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.GSO.4.21.0105160756210.24199-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105161010200.4738-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 May 2001, Alexander Viro wrote:
>
> 	Linus, patch is the first chunk of rootfs stuff. I've tried to
> get it as small as possible - all it does is addition of absolute root
> on ramfs and necessary changes to mount_root/change_root/sys_pivot_root
> and follow_dotdot. Real root is mounted atop of the "absolute" one.

Looks ok, but it also feels like 2.5.x stuff to me. 

Also, there's the question of whether to make ramfs just built-in, or make
_tmpfs_ built in - ramfs is certainly simpler, but tmpfs does the same
things and you need that one for shared mappings etc.

Comments?

		Linus

