Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135177AbRADOji>; Thu, 4 Jan 2001 09:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133113AbRADOjT>; Thu, 4 Jan 2001 09:39:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27995 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132986AbRADOjI>; Thu, 4 Jan 2001 09:39:08 -0500
Date: Thu, 4 Jan 2001 15:39:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Waugh <twaugh@redhat.com>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104153910.A1507@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com> <20010104145229.E17640@athlon.random> <20010104142043.N23469@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010104142043.N23469@redhat.com>; from twaugh@redhat.com on Thu, Jan 04, 2001 at 02:20:43PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 02:20:43PM +0000, Tim Waugh wrote:
> to start with, fall into parport_write anyway (it will just time out

As noted yesterday falling into parport_write will silenty lose data when the
printer is off.

If it's not feasible to make parport_write reliable against power-off
printer, then I recommend to loop in interruptible mode before entering the
main loop (waiting the printer to power-on) like in latest patch from Peter.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
