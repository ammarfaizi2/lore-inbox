Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbRAWUzW>; Tue, 23 Jan 2001 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAWUzM>; Tue, 23 Jan 2001 15:55:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46864 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130667AbRAWUzE>;
	Tue, 23 Jan 2001 15:55:04 -0500
Date: Tue, 23 Jan 2001 21:54:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Steven Cole <scole@lanl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010123215419.A7435@suse.de>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <Pine.LNX.4.21.0101221823070.8054-100000@freak.distro.conectiva> <20010123001155.B8225@suse.de> <01012313294400.01045@spc.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01012313294400.01045@spc.esa.lanl.gov>; from scole@lanl.gov on Tue, Jan 23, 2001 at 01:29:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23 2001, Steven Cole wrote:
> In the following table, 2.4.1-pre8x refers to -pre8 with
> linux/include/linux/blkdev.h modified as suggested.
> A diff to show the changes made is included at the end.
> 
> Here is a summary of the data, followed by the data
> for the individual runs.  Each of the four runs were performed
> in rapid succession, with no boots in between. 

Thanks! Could I talk you into doing one last run? pre8 with
include/linux/elevator.h having these values set for
ELEVATOR_LINUS:

#define ELEVATOR_LINUS                                                  \
((elevator_t) {                                                         \
	1000000,		/* read passovers */
	2000000,		/* write passovers */

Just do this mod on top of your x tree.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
