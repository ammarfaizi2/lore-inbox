Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286807AbRL1KC0>; Fri, 28 Dec 2001 05:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286812AbRL1KCQ>; Fri, 28 Dec 2001 05:02:16 -0500
Received: from mail.zmailer.org ([194.252.70.162]:20353 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S286807AbRL1KCC>;
	Fri, 28 Dec 2001 05:02:02 -0500
Date: Fri, 28 Dec 2001 12:01:45 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 still croaks under heavy load
Message-ID: <20011228120145.G1072@mea-ext.zmailer.org>
In-Reply-To: <001101c18f6e$38b40160$6400a8c0@philxp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c18f6e$38b40160$6400a8c0@philxp>; from kernel@theoesters.com on Thu, Dec 27, 2001 at 11:06:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 11:06:50PM -0800, Phil Oester wrote:
> Have a webserver running Zope (specifically the ZEO db) which dies every
> few days with no messages in syslog.  Locks up so tight a powercycle is
> required to recover.  System has 1gb RAM, 2xSMP, kernel configured with
> 4gb highmem.  

  Do you have RAID1 on the disks ?
  Apparently "noapic" option helps, e.g. breaking the SYMMETRIC part of SMP.
  You may also try "nmi_watchdog=1", if you have serial console attached
  to the box for kernel message logging (and command).

> Since the kernel doesn't provide any info in syslog when it dies, I just
> ran a vmstat 30 to a file and waited for the next untimely demise.
> Here's what happened when it died last time.  Note the sudden surge in
> disk activity (bi) 

   Yes, looks familiar.  My hangups have been during high disc activity too.
   My box is located into a place into which I have difficult access, e.g.
   I can't use it to collect the debug data, and do magics (press reset)
   to recover.

> I'd be more than willing to collect any other data required here, just
> let me know what would be of assistance.  Note though that I only have
> remote access to this box, so getting magic sysrq info could be
> difficult/impossible (tho I do have console access if that helps).
> 
> Thanks,
> 
> Phil Oester

/Matti Aarnio
