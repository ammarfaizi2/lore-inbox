Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132192AbRCVVPT>; Thu, 22 Mar 2001 16:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132187AbRCVVPJ>; Thu, 22 Mar 2001 16:15:09 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:32004 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S131891AbRCVVOw>;
	Thu, 22 Mar 2001 16:14:52 -0500
Date: Thu, 22 Mar 2001 13:32:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: Jens Axboe <axboe@suse.de>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
Message-ID: <20010322133235.C31@(none)>
In-Reply-To: <3AB47DA4.795B609B@yahoo.com> <20010318223558.L29105@suse.de> <3AB9C53E.75D7D965@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AB9C53E.75D7D965@yahoo.com>; from p_gortmaker@yahoo.com on Thu, Mar 22, 2001 at 04:26:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>   ide1: unexpected interrupt, status=0x58, count=1
>   hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>   hdc: drive not ready for command
> 
> all with the same timestamp in the syslog.  (IRQ timeout followed by
> unexpected IRQ ... ???  Hrrm.)

Not *so* strange.

I'm waiting for interrupt. It does not come, so I start interrupt routine,
anyway.It finds something strange in registers, and says "unexpected interrupt".

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

