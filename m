Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbTCMSyJ>; Thu, 13 Mar 2003 13:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262530AbTCMSyJ>; Thu, 13 Mar 2003 13:54:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52143 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262525AbTCMSyH>;
	Thu, 13 Mar 2003 13:54:07 -0500
Date: Thu, 13 Mar 2003 20:04:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
Message-ID: <20030313190421.GR836@suse.de>
References: <20030313182812.7679.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313182812.7679.qmail@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Felipe Alfaro Solana wrote:
> ----- Original Message ----- 
> From: Jens Axboe <axboe@suse.de> 
> Date: 	Thu, 13 Mar 2003 18:54:54 +0100 
> To: Jeremy Fitzhardinge <jeremy@goop.org> 
> Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155! 
>  
> > On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote: 
> > > I was reading back a freshly burned CD from my shiny new Plexwriter 
> > > 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted 
> >  
> > out of curiousity, why? ide-cd should work much better than ide-scsi in 
> > 2.5, if it doesn't I'd like to know. 
>  
> There are still userspace CD burning programs that do not yet 
> support ATAPI burning interface. "cdrecord" does support it, 
> but K3B (a KDE burning frontend to cdrecord and company) 
> only works with SCSI or IDE-SCSI burners (well, or at least 
> I have been unable to convince it to use the ATAPI interface 
> to my Sony burner). 

That is quite possible. Maybe someone could compile a list of programs
that still use read/write to /dev/sg*?

I had at some point planned to allow arbitrary block device -> /dev/sg*
mapping, maybe it would be a good idea to finish that thought. Then you
wouldn't have to rely on programs using SG_IO ioctl, which does seem
like a bad idea.

-- 
Jens Axboe

