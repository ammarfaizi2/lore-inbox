Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290870AbSAaDTb>; Wed, 30 Jan 2002 22:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290873AbSAaDTW>; Wed, 30 Jan 2002 22:19:22 -0500
Received: from ns.suse.de ([213.95.15.193]:7182 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290870AbSAaDTF>;
	Wed, 30 Jan 2002 22:19:05 -0500
Date: Thu, 31 Jan 2002 04:19:01 +0100
From: Dave Jones <davej@suse.de>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Various issues with 2.5.2-dj6
Message-ID: <20020131041901.H31313@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan <wfilardo@fuse.net>, lkml <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
In-Reply-To: <3C58B3DD.3000800@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C58B3DD.3000800@fuse.net>; from wfilardo@fuse.net on Wed, Jan 30, 2002 at 10:02:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:02:53PM -0500, Nathan wrote:

 > Issue 1: kernel does not compile without SMP support (missing references 
 > to global_irq_holder in sched.c)

 Possibly an issue with preempt on top of my tree. Builds fine UP & SMP
 here without it.

 > Issue 2: Two IEEE1934 modules needed to have "#include 
 > <linux/interrupt.h>" added (host.c and another one I forget)

 Can you send the gcc error messages of these ?
 (A patch would be nice too)
 
 > Issue 3: Turning off hotplug (/etc/init.d/hotplug stop on a Debian 
 > unstable box - updated today) gives the following oopses (captured by 
 > "klogd -x") - see below.

 Could be related to the usb-driverfs changes, 2.5.3-dj1 is still cooking
 here, but has Greg KH's updated version of this work. See if you
 can repeat it later..

 > Issue 4: Unmounting the drives read-only with Alt-SysRQ-U gives the 
 > following oops and locks the box except for further Alt-SysRQ-* (mount 
 > -o ro,remout /mount/point works fine) - see below.

 The ext3 related oops, hmm. Oopsing in generic_file_write seems odd.
 I'm wondering if the system was in such a state at this point that the
 subsequent oopses are just noise.

 > Issue 5: Mouse (via /dev/input/mice) seems slugish this time (after a 
 > fresh cold boot).  Seemed fine first few times on 2.5.2-dj6 and fine 
 > under 2.4.18-pre7 /dev/psaux.

 This is the 2nd report I've had of this. Hopefully Vojtech has
 an answer for this.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
