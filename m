Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315238AbSD2Xam>; Mon, 29 Apr 2002 19:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSD2Xal>; Mon, 29 Apr 2002 19:30:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22797 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315238AbSD2Xal>; Mon, 29 Apr 2002 19:30:41 -0400
From: Daniel Quinlan <quinlan@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15565.55114.422518.394576@transmeta.com>
Date: Mon, 29 Apr 2002 16:29:14 -0700 (PDT)
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: <quinlan@transmeta.com>, <marcelo@conectiva.com.br>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cramfs 1/6 - timestamp in includes
In-Reply-To: <Pine.LNX.4.33.0204291326230.25892-100000@ado-2.axis.se>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: quinlan@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson writes:

> 1. Support for fstime and EDITION_TIMESTAMP in cramfs include files.
>    Uses the edition field in fsid if the CRAMFS_FLAG_EDITION_TIMESTAMP
>    flag is set.
> 2. Support for fstime in fs/cramfs/inode.c together with
>    fixing hardcoded blocksize conversion
>    (Now uses /(PAGE_CACHE_SIZE/1024) instead of >> 2).
> 3. The tools: mkcramfs.c and cramfsck.c: Add support for timestamp in the
>    edition field (fstime) and added the option -b blocksize.
>    For cramfsck.c it also fixes a segfault that occured in the error
>    message if the incorrect blocksize is used (order of arguments wrong).

These first three look good.  I made a few minor changes and merged it
with the big-endian patch, so I'll send you my current version before
sending it onwards to Marcelo and Linus.

The big-endian patch was waiting for 2.4.19 to be released, but maybe I
should just submit it if 2.4.19 is going to be a while.  Also, all of
the big-endian changes are checked into the CVS tree now.

Dan
