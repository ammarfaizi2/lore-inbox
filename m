Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRGTIQV>; Fri, 20 Jul 2001 04:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbRGTIQL>; Fri, 20 Jul 2001 04:16:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44559 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266730AbRGTIQC>; Fri, 20 Jul 2001 04:16:02 -0400
Date: Fri, 20 Jul 2001 01:15:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, <linux-scsi@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
In-Reply-To: <20010720092202.A9525@suse.de>
Message-ID: <Pine.LNX.4.31.0107200111280.718-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 20 Jul 2001, Jens Axboe wrote:
>
> Attached are two patches -- one that should fix DAC960 for this new
> completion scheme, and one that corrects the corrected comment in
> blkdev.h :-)

No, the correction of the correction is worse.

The paging stuff doesn't use any of this. The paging stuff use the page
cache lock bit, and always has.

The only thing that uses request completion checking are special commands,
like the initial SCSI spin-up etc (scsi_init_one()).

		Linus

