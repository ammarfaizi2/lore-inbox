Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSE0A5s>; Sun, 26 May 2002 20:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316476AbSE0A5s>; Sun, 26 May 2002 20:57:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47883 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316475AbSE0A5r>; Sun, 26 May 2002 20:57:47 -0400
Date: Sun, 26 May 2002 17:57:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
In-Reply-To: <3CF14834.7FF3E72E@zip.com.au>
Message-ID: <Pine.LNX.4.44.0205261756410.1400-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 May 2002, Andrew Morton wrote:
>
> One fix would be to teach shrink_cache() to wait on PG_locked for swap
> pages.  The other approach is to set both PG_locked and PG_writeback
> for swap pages so they can be handled in the same manner as file-backed
> pages in shrink_cache().

How about making them do exactly what normal writeout does, namely drop
the locked bit too. Is there any advantage to holding it any more? The
difference between swap writeout and normal writeout seems to be fairly
arbitrary at this point.

			Linus

