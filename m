Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133082AbRADNw5>; Thu, 4 Jan 2001 08:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133108AbRADNwr>; Thu, 4 Jan 2001 08:52:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15442 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133052AbRADNwd>; Thu, 4 Jan 2001 08:52:33 -0500
Date: Thu, 4 Jan 2001 14:52:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Waugh <twaugh@redhat.com>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010104145229.E17640@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010104112027.G23469@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010104112027.G23469@redhat.com>; from twaugh@redhat.com on Thu, Jan 04, 2001 at 11:20:27AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 11:20:27AM +0000, Tim Waugh wrote:
> I wonder where the EIO is coming from though.  Grep only shows up

I think lp_check_status.

	} else if (!(status & LP_PSELECD)) {
		if (last != LP_PSELECD) {
			last = LP_PSELECD;
			printk(KERN_INFO "lp%d off-line\n", minor);
		}
		error = -EIO;
	} else if (!(status & LP_PERRORP)) {
		if (last != LP_PERRORP) {
			last = LP_PERRORP;
			printk(KERN_INFO "lp%d on fire\n", minor);
		}
		error = -EIO;

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
