Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbRERUBf>; Fri, 18 May 2001 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbRERUBP>; Fri, 18 May 2001 16:01:15 -0400
Received: from WARSL401PIP1.highway.telekom.at ([195.3.96.69]:56600 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S261503AbRERUBK>;
	Fri, 18 May 2001 16:01:10 -0400
Date: Fri, 18 May 2001 21:59:52 +0200
From: Eduard Hasenleithner <eduardh@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010518215952.A7919@moserv.hasi>
Mail-Followup-To: Eduard Hasenleithner <eduardh@aon.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010518210226.A7147@moserv.hasi> <20010518212531.A6763@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010518212531.A6763@suse.de>; from axboe@suse.de on Fri, May 18, 2001 at 09:25:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 09:25:31PM +0200, Jens Axboe wrote:
> On Fri, May 18 2001, Eduard Hasenleithner wrote:
> > I have a problem with the buffering mechanism of my blockdevice,
> > namely a ide_scsi DVD-ROM drive. After inserting a DVD and reading
> > data linearly from the DVD, an excessive amount of buffer memory gets
> > allocated.
> > 
> > This can easily be reproduced with
> > 	cat /dev/sr0 > /dev/null
> > 
> > Remember, nearly the same task is carried out when playing a DVD.
> > 
> > As a result the system performance goes down. I'm still able to use
> > my applications, but es every single piece of unused memory is swapped
> > out, and swapping in costs a certain amount of time.
> 
> That's why streaming media applications like a dvd player should use raw
> I/O -- to bypass system cache. See /dev/raw*
> 

Oh, thank you. That was very fast!

I use xine. To be honest, the procedure of how to create a raw device
is described in their FAQ. But it is not described, what the raw device
does, only that it provides a speed improvement.

Until today, I didn't know what rawio actually does. Strange that I didn't
come across on some information about it.

Was there a official announcement of the availability of this feature?
Is some more detailled information about the rawio existing?

-- 
Eduard Hasenleithner
student of
Salzburg University of Applied Sciences and Technologies
