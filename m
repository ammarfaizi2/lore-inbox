Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRERT0P>; Fri, 18 May 2001 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbRERT0F>; Fri, 18 May 2001 15:26:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27404 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261473AbRERTZv>;
	Fri, 18 May 2001 15:25:51 -0400
Date: Fri, 18 May 2001 21:25:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Eduard Hasenleithner <eduardh@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010518212531.A6763@suse.de>
In-Reply-To: <20010518210226.A7147@moserv.hasi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010518210226.A7147@moserv.hasi>; from eduardh@aon.at on Fri, May 18, 2001 at 09:02:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18 2001, Eduard Hasenleithner wrote:
> I have a problem with the buffering mechanism of my blockdevice,
> namely a ide_scsi DVD-ROM drive. After inserting a DVD and reading
> data linearly from the DVD, an excessive amount of buffer memory gets
> allocated.
> 
> This can easily be reproduced with
> 	cat /dev/sr0 > /dev/null
> 
> Remember, nearly the same task is carried out when playing a DVD.
> 
> As a result the system performance goes down. I'm still able to use
> my applications, but es every single piece of unused memory is swapped
> out, and swapping in costs a certain amount of time.

That's why streaming media applications like a dvd player should use raw
I/O -- to bypass system cache. See /dev/raw*

-- 
Jens Axboe

