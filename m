Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283850AbRK3V4S>; Fri, 30 Nov 2001 16:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283826AbRK3V4H>; Fri, 30 Nov 2001 16:56:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18451 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283821AbRK3V4B>; Fri, 30 Nov 2001 16:56:01 -0500
Date: Fri, 30 Nov 2001 13:50:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <20011130145223.Q15936@lynx.no>
Message-ID: <Pine.LNX.4.33.0111301349230.1185-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2001, Andreas Dilger wrote:
>
> Well, just doing a code check of the update_atime() and UPDATE_ATIME()
> users, and they are all in readlink(), follow_link(), open_namei(),
> and various fs _readdir() codes.  None of them (AFAICS) depend on the
> mark_inode_dirty() as a side-effect.  This means it should be safe.

More importantly, _if_ somebody depended on the side effects, they'd have
been thwarted by the "noatime" mount option anyway, so any such bug would
not be a new bug.

		Linus

