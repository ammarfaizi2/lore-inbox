Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbRAZOgn>; Fri, 26 Jan 2001 09:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbRAZOge>; Fri, 26 Jan 2001 09:36:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130847AbRAZOgX>;
	Fri, 26 Jan 2001 09:36:23 -0500
Date: Fri, 26 Jan 2001 15:36:14 +0100
From: Jens Axboe <axboe@suse.de>
To: "Gregory T. Norris" <haphazard@socket.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 CDROM problem, ILLEGAL REQUEST
Message-ID: <20010126153614.B19513@suse.de>
In-Reply-To: <20010121120512.A22848@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010121120512.A22848@glitch.snoozer.net>; from haphazard@socket.net on Sun, Jan 21, 2001 at 12:05:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21 2001, Gregory T. Norris wrote:
> When playing audio CDs under kernel 2.4.0, syslog is showing the
> following message repeatedly:
> 
>      sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> 
> The command line utility cdplay seems to only cause this occasionally,
> when I start playing a CD or skip to a different track, while gnome's
> gtcd will generate it every few seconds... presumably gtcd is regularly
> querying the drive.
> 
> I'm pretty sure that this wasn't occurring under the 2.4.0-testX
> kernels, but I haven't verified this as they aren't currently
> installed.

Yes it's a new and known bug, sr_do_ioctl now does retries etc for
queued packets from the uniform layer and thus we get some printkts
that you normally wouldn't see. The error should only be cosmetic.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
