Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbTBSU1I>; Wed, 19 Feb 2003 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTBSU1I>; Wed, 19 Feb 2003 15:27:08 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:40464 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S267188AbTBSU1H>;
	Wed, 19 Feb 2003 15:27:07 -0500
Subject: Re: hard lockup on 2.4.20 w/ nfs over frees/wan
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1045634189.4761.44.camel@zaphod>
References: <1045634189.4761.44.camel@zaphod>
Content-Type: text/plain
Organization: 
Message-Id: <1045686971.8084.2.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 15:36:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

didn't get any responses on this, but its crashes again a few times
again today, the status code it printed out was ffff.  

On Wed, 2003-02-19 at 00:56, Shaya Potter wrote:
> I'm trying to use frees/wan 1.99 w/ NFSv3.  I've been testing it w/
> large r and wsize's (32k each).  When used w/o ipsec, it seems to work
> fine.  When used w/ ipsec, make dep on a kernel source tree has
> consistently frozen up these IBM Netfinity boxes (2*933mhz P3s w/ smp
> kernel).  One time the last thing the kernel printk'd was
> 
> pcnet32.c:	    printk(KERN_ERR "%s: Bus master arbitration failure,
> status %4.4x.\n",
> 
> but didn't record the status number (well it was eth0: Bus master....,
> and it's using a pcnet32 controller, so assume that's the line). 
> Usually it's locked up w/o printk'ing anything, last things I see on
> console are the normal ipsec printk's
> 
> Is it possible that the r/w size's are causing issues when used in
> conjuction w/ ipsec?  Am I triggering some sort of race condition?  The
> NFS client is running the exact same kernel on the same exact hardware
> and hasn't had an issue yet.
> 
> any ideas on what I can do to debug it?
> 
> thanks,
> 
> shaya
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

