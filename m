Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280830AbRKBU5w>; Fri, 2 Nov 2001 15:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280831AbRKBU5m>; Fri, 2 Nov 2001 15:57:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29522 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280830AbRKBU5g>; Fri, 2 Nov 2001 15:57:36 -0500
Date: Fri, 2 Nov 2001 21:57:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zlatko's I/O slowdown status
Message-ID: <20011102215729.K1274@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0110261018270.1001-100000@penguin.transmeta.com> <87k7xfk6zd.fsf@atlas.iskon.hr> <20011102065255.B3903@athlon.random> <87g07xdj6x.fsf@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87g07xdj6x.fsf@atlas.iskon.hr>; from zlatko.calusic@iskon.hr on Fri, Nov 02, 2001 at 09:14:14PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 09:14:14PM +0100, Zlatko Calusic wrote:
> It was write caching. Somehow disk was running with write cache turned

Ah, I was going to ask you to try with:

	/sbin/hdparm -d1 -u1 -W1 -c1 /dev/hda

(my settings, of course not safe for journaling fs, safe to use it only
with ext2 and I -W0 back during /etc/init.d/halt) but I assumed you were
using the same hdparm settings in -ac and mainline. Never mind, good
that it's solved now :).

Andrea
