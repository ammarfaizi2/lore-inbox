Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbRDRA2q>; Tue, 17 Apr 2001 20:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDRA2i>; Tue, 17 Apr 2001 20:28:38 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:22794 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S132934AbRDRA2S>; Tue, 17 Apr 2001 20:28:18 -0400
Date: Tue, 17 Apr 2001 17:28:13 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Is printing broke on sparc ?
In-Reply-To: <Pine.LNX.4.32.0104171707310.22166-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.32.0104171720370.22166-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Tim ,

On Tue, 17 Apr 2001, Mr. James W. Laferriere wrote:
> On Tue, 17 Apr 2001, Tim Waugh wrote:
> > [...]
> > > /c#eodiecnyotai rhernili s to rpaemn
> > >                                     s eehpo o-.ROLPR0 roif{\=sl:x
> > >                                                                  	/p:ao/lr
> > This looks like characters are getting missed out, rather than
> > anything getting garbled.  The above characters all appear in
> > /etc/printcap in the order shown.  Obviously there isn't enough
> > redundancy in /etc/printcap for the print-out to be useful despite
> > that. :-)
> 	;-) .
> > Please try adjusting the 'udelay (1)' lines in
> > drivers/parport/ieee1284_ops.c:parport_ieee1284_write_compat to be
> > larger delays (for example, try replacing the 1s with 2s, or 5s, and
> > see if that makes things better).
> 	I am going to look and see if there might be a ioctl for that
> 	function .  Failing that I shall recompile the kernel with each
> 	of those values & test until successful or it seems futile .
	Ok , There isn't a sysctl available to do that .  I am also a
	little worried about the 'none' in ths below .

root@udragon:~# sysctl -A | grep -i parp
dev.parport.parport0.devices.active = none
dev.parport.parport0.modes =
dev.parport.parport0.dma = -1
dev.parport.parport0.irq = 6814784
dev.parport.parport0.base-addr = 2198696099840	0
dev.parport.parport0.spintime = 500
dev.parport.default.spintime = 500
dev.parport.default.timeslice = 200

	But I do see timeslices in the 'lp' of /proc/...
dir /proc/sys/dev/parport/parport0/devices/lp
total 0
   0 dr-xr-xr-x    2 root     root            0 Apr 17 17:26 ./
   0 dr-xr-xr-x    3 root     root            0 Apr 17 17:26 ../
   0 -rw-r--r--    1 root     root            0 Apr 17 17:26 timeslice

	Off to build 3 kernels on this old tub .  Twyl ,  JimL

> > Let me know what you need to change to get it working.
> > Thanks,
> > Tim.
> > */
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

