Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287494AbSAEEUe>; Fri, 4 Jan 2002 23:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAEEUX>; Fri, 4 Jan 2002 23:20:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287494AbSAEEUM>; Fri, 4 Jan 2002 23:20:12 -0500
Date: Fri, 4 Jan 2002 20:19:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [FIX] missing piece from fs/super.c in -pre8
In-Reply-To: <Pine.GSO.4.21.0201042307430.27334-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201042017410.1371-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Alexander Viro wrote:
>
> Linus, I doubt that making the thing inline was a good idea.  Reason: for
> filesystems like NFS we almost definitely want something like server name
> + root path to identify the superblock.  And that can easily grow past
> 32 bytes.

Since it is only used for printouts, I'd much rather have simpler code.
Especially since I couldn't convince myself that all users in your version
even initialized the dang pointer.

There is nothing wrong with having a requirement that informational stuff
be limited to X characters..

		Linus

