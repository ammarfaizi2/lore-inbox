Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHaSiM>; Fri, 31 Aug 2001 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268908AbRHaSiC>; Fri, 31 Aug 2001 14:38:02 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32441 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268901AbRHaShr>; Fri, 31 Aug 2001 14:37:47 -0400
Date: Fri, 31 Aug 2001 11:33:08 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010831113308.A28193@us.ibm.com>
In-Reply-To: <20010830134930.F23680@us.ibm.com> <20010831075613.A2855@suse.de> <20010831075201.N23680@us.ibm.com> <20010831200333.A9069@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831200333.A9069@suse.de>; from axboe@suse.de on Fri, Aug 31, 2001 at 08:03:33PM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Please elaborate on "no, no, no".   Are you suggesting that no further
> > improvements can be made or should be attempted on the 2.4 i/o subsystem?
> 
> Of course not. The no no no just means that attempting to globally remove the
> io_request_lock at this point is a no-go, so don't even go there. The
> sledgehammer approach will not fly at this point, it's just way too risky.

I agree that reducing locking scope is often problematic.  However,
this patch does not globally remove the io_request_lock.  The purpose
of the patch is to protect request queue integrity with a per queue 
lock instead of the global io_request_lock.  My intent was to leave 
other io_request_lock serialization intact.  Any insight into whether
the patch leaves data unprotected would be appreciated.

Jonathan

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

