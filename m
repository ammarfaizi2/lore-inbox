Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbRDZTpP>; Thu, 26 Apr 2001 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135477AbRDZToz>; Thu, 26 Apr 2001 15:44:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9024 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131638AbRDZToq>; Thu, 26 Apr 2001 15:44:46 -0400
Date: Thu, 26 Apr 2001 21:39:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426213901.A819@athlon.random>
In-Reply-To: <20010426201236.W819@athlon.random> <Pine.LNX.4.21.0104261141280.4480-100000@penguin.transmeta.com> <20010426211557.Z819@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010426211557.Z819@athlon.random>; from andrea@suse.de on Thu, Apr 26, 2001 at 09:15:57PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 09:15:57PM +0200, Andrea Arcangeli wrote:
> maybe not but I need to check some more bit to be sure.

yes we probably don't need it for fs against fs in 2.4 because we make
the new metadata block visible to a reader (splice) only after they're
all uptodate and all directory operations are serialized by the vfs
(with the i_zombie).

Andrea
