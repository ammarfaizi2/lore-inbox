Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRAPJ1Y>; Tue, 16 Jan 2001 04:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRAPJ1O>; Tue, 16 Jan 2001 04:27:14 -0500
Received: from 62-6-231-118.btconnect.com ([62.6.231.118]:6404 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130204AbRAPJ1E>;
	Tue, 16 Jan 2001 04:27:04 -0500
Date: Tue, 16 Jan 2001 09:29:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Bobo Rajec <bobo@bspc.sk>
cc: linux-kernel@vger.kernel.org, daryll@users.sourceforge.net
Subject: Re: 2.4.0 bug: file /proc/dri 4 times in ls listing
In-Reply-To: <Pine.LNX.4.21.0101160924080.744-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0101160928130.744-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Tigran Aivazian wrote:
> Fixing this requires either a new filesystem type (drifs) or
> (simpler!) redesigning dri to separate common things into a separate
> dri_core thing shared amongst them.

just for completeness -- there is the 3rd option -- one could just fix the
hack which is there (or was there half a year ago when I looked at
it) which is supposed to detect that a file in /proc is already
present. It is just not esthetically pleasant (good to eyes :) so I
omitted this from the options...

> 
> Regards,
> Tigran
> 
> On Tue, 16 Jan 2001, Bobo Rajec wrote:
> 
> > 
> > Hi,
> > 
> > I'm running kernel 2.4.0 on Redhat 7.0. I tried to get direct
> > rendering running (it failed, but that's another story). Today I
> > noticed something strange in /proc: dri appears there 4 times.
> > 
> > ls /proc:
> > ...
> > -r--r--r--    1 root     root            0 Jan 16 08:57 dma
> > dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
> > dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
> > dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
> > dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
> > dr-xr-xr-x    2 root     root            0 Jan 16 08:57 driver
> > ...
> > 
> > Chdir /proc/dri/0 works fine:
> > 
> > bobo:/proc/dri/0>ls
> > bufs  clients  histo  mem  name  queues  vm  vma
> > 
> > No dri modules, everything is linked in (I know I don't need all of
> > these, but I have lots of memory, so...).
> > 
> > ...
> > CONFIG_AGP=y
> > CONFIG_AGP_INTEL=y
> > CONFIG_AGP_I810=y
> > CONFIG_AGP_VIA=y
> > CONFIG_AGP_AMD=y
> > CONFIG_AGP_SIS=y
> > CONFIG_AGP_ALI=y
> > CONFIG_DRM=y
> > CONFIG_DRM_TDFX=y
> > CONFIG_DRM_GAMMA=y
> > CONFIG_DRM_R128=y
> > CONFIG_DRM_I810=y
> > CONFIG_DRM_MGA=y
> > ...
> > 
> > Regards,
> > 	bobo
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
