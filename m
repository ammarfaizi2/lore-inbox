Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBVXLs>; Thu, 22 Feb 2001 18:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130296AbRBVXLi>; Thu, 22 Feb 2001 18:11:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:45869 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129396AbRBVXL0>; Thu, 22 Feb 2001 18:11:26 -0500
Date: Fri, 23 Feb 2001 00:12:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010223001252.D30330@athlon.random>
In-Reply-To: <20010222223811.A29372@athlon.random> <Pine.LNX.4.21.0102221832470.2401-100000@freak.distro.conectiva> <20010222235700.B30330@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010222235700.B30330@athlon.random>; from andrea@suse.de on Thu, Feb 22, 2001 at 11:57:00PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 11:57:00PM +0100, Andrea Arcangeli wrote:
> unsane to wait kupdate to submit 10G of ram to a single harddisk before
> unplugging on a 30G machine.

actually kupdate will unplug itself the queue but in theory it can grow the
queue still up to such level after the I/O started. I think we'd better
add an high limit on the in flight I/O watermark.

Andrea
