Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277322AbRJVAEh>; Sun, 21 Oct 2001 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277330AbRJVAER>; Sun, 21 Oct 2001 20:04:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:62282 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277322AbRJVAEJ>; Sun, 21 Oct 2001 20:04:09 -0400
Date: Mon, 22 Oct 2001 02:04:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: jogi@planetzork.ping.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5aa1
Message-ID: <20011022020429.C8408@athlon.random>
In-Reply-To: <20011019061914.A1568@athlon.random> <20011021211726.A476@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011021211726.A476@planetzork.spacenet>; from jogi@planetzork.ping.de on Sun, Oct 21, 2001 at 09:17:26PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 09:17:26PM +0200, jogi@planetzork.ping.de wrote:
> 2.4.13-pre3aa1:   4:54.39   6:00.32   10:15.06     *
					^^^^^^^^
> 2.4.13-pre5aa1:   4:54.61   5:10.38   5:19.68   5:40.37
					^^^^^^^

this is interesting. I'm also wondering what you'd get if you used:

	echo 8 > /proc/sys/vm/vm_scan_ratio
	echo 1 > /proc/sys/vm/vm_mapped_ratio
	echo 3 > /proc/sys/vm/vm_balance_ratio

(or also the other combination that I suggested in the other emails)

Anyways you can probably skip the above test and wait for a further
update that changes more than just the default sysctl values (also
notably it introduces the PG_launder logic originated from a discussion
with Marcelo and Linus, resemling somehow part of the PG_wait_for_IO
write throttling logic that I had in 2.4.12aa1 and 2.4.13pre3aa1, but I
doubt pre3aa1 was slower because of that, and in case next -aa will
slowdown again I'll later ask you to try with a one liner patch that
will disable the write throttling for writepage again [like pre5aa1 did]
just to make sure it's not the one that hurts :)

thanks to you too for the feedback!

Andrea
