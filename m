Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269068AbRHPXgS>; Thu, 16 Aug 2001 19:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHPXgJ>; Thu, 16 Aug 2001 19:36:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269068AbRHPXft>; Thu, 16 Aug 2001 19:35:49 -0400
Date: Fri, 17 Aug 2001 01:35:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Mark Hemment <markhe@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align VM locks
Message-ID: <20010817013552.F8726@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0108162006270.3340-300000@alloc.wat.veritas.com> <Pine.LNX.4.33.0108161625160.5368-100000@touchme.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108161625160.5368-100000@touchme.toronto.redhat.com>; from bcrl@redhat.com on Thu, Aug 16, 2001 at 04:27:11PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 04:27:11PM -0400, Ben LaHaise wrote:
> Here's the patch I sent a few days ago that provides a couple of generic
> kmap_atomic entries for exactly this purpose and uses them for page cache
> access.  Not only does it avoid unneeded shootdowns, but it means that
> spurious schedules won't happen under extreme loads.

if you want to take this route you don't need to define KM_USER*, just
rename KM_BOUNCE_WRITE to KM_KERNEL and use it always.

Andrea
