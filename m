Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbRGKBy7>; Tue, 10 Jul 2001 21:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbRGKByt>; Tue, 10 Jul 2001 21:54:49 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:21009 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S267182AbRGKByg>; Tue, 10 Jul 2001 21:54:36 -0400
Date: Tue, 10 Jul 2001 19:58:21 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Brian Strand <bstrand@switchmanagement.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010710195821.A5730@vger.timpanogas.org>
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com>; from bstrand@switchmanagement.com on Tue, Jul 10, 2001 at 05:45:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 05:45:16PM -0700, Brian Strand wrote:
> We are running 3 Oracle servers, each dual CPU, 1 1GB and 2 2GB memory, 
>  between 36-180GB of RAID.  On June 26, I upgraded all boxes from Suse 
> 7.0 to Suse 7.2 (going from kernel version 2.2.16-40 to 2.4.4-14). 
>  Reviewing Oracle job times (jobs range from a few minutes to 10 hours) 
> before and after, performance is almost exactly twice as poor after the 
> upgrade versus before the upgrade.  Nothing in the hardware or Oracle 
> configuration has changed on any server.  Does anyone have any ideas as 
> to what might cause this?
> 
> Thanks,
> Brian Strand
> CTO Switch Management
> 
> 

Oracle performance is critical in requiring fast disk access.  Oracle is
virtually self-contained with regard to the subsystems it uses -- it 
provides most of it's own.  Oracle slowdowns are related to either 
problems in the networking software for remote SQL operations, and 
disk access witb regard to jobs run locally.  If it's slower for local
SQL processing as well as remote I would suspect a problem with the 
low level disk interface.

Jeff


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
