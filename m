Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129548AbRBWPim>; Fri, 23 Feb 2001 10:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRBWPid>; Fri, 23 Feb 2001 10:38:33 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42124 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129548AbRBWPiU>; Fri, 23 Feb 2001 10:38:20 -0500
Date: Fri, 23 Feb 2001 10:12:33 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1ac20
In-Reply-To: <Pine.LNX.4.33.0102211815210.2261-100000@badlands.lexington.ibm.com>
Message-ID: <Pine.LNX.4.33.0102231005220.2402-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Richard A Nelson wrote:

> On Wed, 21 Feb 2001, Alan Cox wrote:
>
> >
> > Can you stick an if(dev!=NULL) in front of that and let me know if that
> > fixes it - just to verify thats the problem spot
>
> Compiling now, will reboot in the am (if it aint done soon) -
> don't want it rebooting all night if this isn't it ;-}

Sigh, it appears that the problem is actually neither of the above
lines.

I even tried 2.4.2 and had the same problem, then I noticed that 2.4.2
also contains the same update ;-}

I put an if(dev == NULL)printk...else in both spots and rebooted.

Then (I gotta start drinking more coffee, or increase Copenhagen
intake), I noticed that the actual oops is from modprobe!!!!

I've not been able to get a oops trace because the error either causes
a reboot, or hang (either case, e2fsck is run at reboot).

Heres some system info that might be useful:
Kernel modules         2.4.2
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.91.0.2
Linux C Library        2.2.2
Dynamic linker         ldd (GNU libc) 2.2.2
Procps                 2.0.7
Mount                  2.10s
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11

I'll be happy to reboot and capture the oops, if someone can help me
make sure it gets logged (serial console not a possibility, the other
box is currently in pieces).

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

