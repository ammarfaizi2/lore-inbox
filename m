Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRL3Rkw>; Sun, 30 Dec 2001 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281794AbRL3Rkn>; Sun, 30 Dec 2001 12:40:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5130 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281780AbRL3Rkg>; Sun, 30 Dec 2001 12:40:36 -0500
Date: Sun, 30 Dec 2001 09:40:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        <torrey.hoffman@myrio.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrdkern
    el panic woes
In-Reply-To: <3C2EC95A.79868A85@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112300918430.4869-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Dec 2001, Andrew Morton wrote:
>
> And what should we do with BH_New?

The only point of BH_New was to not need this horror in three different
places, and have the BH_New bit as a way of saying "this buffer has no
contents yet", and fill it with zeroes in just _one_ place (ie the
readpage path).

However, I don't think it was ever implemented, so if you prefer the
straightforward (brute-force but ugly) approach, just get rid of it.

			Linus

