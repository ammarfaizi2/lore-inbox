Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSLPJIn>; Mon, 16 Dec 2002 04:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265713AbSLPJIn>; Mon, 16 Dec 2002 04:08:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41386 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265711AbSLPJIm>;
	Mon, 16 Dec 2002 04:08:42 -0500
Date: Mon, 16 Dec 2002 10:16:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove error message on illegal ioctl
Message-ID: <20021216091615.GQ11892@suse.de>
References: <1039832542.5305.455.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039832542.5305.455.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13 2002, Robert Love wrote:
> This error message is uber annoying and needs to go.  Non-root can flood
> the console with this junk on invalid SCSI CD-ROM ioctl(),
> and that is exactly what gnome-cd does.
> 
> An illegal ioctl() returns an error to the program.  That is
> sufficient - we do not need KERN_ERROR warnings all over the place.
> Especially when any user can cause them at any rate.
> 
> This patch, against 2.5.51, removes the message.  Linus, please
> apply.

Vetoed. That particular function is also used for generic command passed
down from the uniform cdrom layer, and it's indeed very handy to see
errors if they occur from there.

Your non-root user still has to be able to open the cdrom.

-- 
Jens Axboe

