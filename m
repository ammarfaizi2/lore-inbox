Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbQJ2VzY>; Sun, 29 Oct 2000 16:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQJ2VzN>; Sun, 29 Oct 2000 16:55:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60685 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129379AbQJ2Vy5>;
	Sun, 29 Oct 2000 16:54:57 -0500
Date: Sun, 29 Oct 2000 14:45:43 -0800
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@speakeasy.org>
Cc: Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
Message-ID: <20001029144543.D615@suse.de>
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de> <39FC78BF.90607@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FC78BF.90607@speakeasy.org>; from miles@speakeasy.org on Sun, Oct 29, 2000 at 11:21:35AM -0800
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29 2000, Miles Lane wrote:
> >> There were still some stalls but they only lasted a couple of
> >> seconds. The patch did make a difference and for the better.
> > 
> > 
> > Ok, still needs a bit of work. Thanks for the feedback.
> 
> Have you resolved this problem completely, now?
> 
> I am testing the USB Storage support with my ORB backup
> drive.  When I run:
> 
> 	dd if=/dev/zero of=/dev/sda bs=1k count=2G
> 
> The drive gets data quickly for about thirty seconds.
> Then the throughput drops off to about ten percent
> of its previous transfer rate.  This dropoff appears to
> be due to conflict over accessing filesystems.  Specifically,
> I have USB_STORAGE_DEBUG enabled, which shoots a ton of
> debugging output into my kernel log.  When the throughput
> to the ORB drive falls off, all writing to the syslog
> ceases.  At least, that's what "tail -f" shows.
> 
> I would be happy to test any patches you have for this
> problem.

Could you send vmstat 1 info from the start of the copy
and until the i/o rate drops off?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
