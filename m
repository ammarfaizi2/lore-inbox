Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266051AbRGKUJF>; Wed, 11 Jul 2001 16:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266013AbRGKUIz>; Wed, 11 Jul 2001 16:08:55 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48798 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266051AbRGKUIx>; Wed, 11 Jul 2001 16:08:53 -0400
Date: Thu, 12 Jul 2001 01:43:28 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Jens Axboe <axboe@suse.de>
Cc: mike.anderson@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010712014328.A14094@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711090257.B27097@us.ibm.com> <20010711212022.H712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010711212022.H712@suse.de>; from axboe@suse.de on Wed, Jul 11, 2001 at 09:20:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 09:20:22PM +0200, Jens Axboe wrote:
> True. In theory it would be possible to do request slot stealing from
> idle queues, in fact it's doable without adding any additional overhead
> to struct request. I did discuss this with [someone, forgot who] last
> year, when the per-queue slots where introduced.
> 
> I'm not sure I want to do this though. If you have lots of disks, then
> yes there will be some wastage if they are idle. IMO that's ok. What's
> not ok and what I do want to fix is that slower devices get just as many
> slots as a 15K disk for instance. For, say, floppy or CDROM devices we
> really don't need to waste that much RAM. This will change for 2.5, not
> before.

Unless there is some serious evidence substantiating the need for
stealing request slots from other devices to avoid starvation, it
makes sense to avoid it and go for a simpler scheme. I suspect that device
type based slot allocation should just suffice.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
