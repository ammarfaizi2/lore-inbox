Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAPIHu>; Tue, 16 Jan 2001 03:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRAPIHk>; Tue, 16 Jan 2001 03:07:40 -0500
Received: from proxy.bspc.sk ([195.80.172.1]:33043 "HELO proxy.bspc.sk")
	by vger.kernel.org with SMTP id <S129485AbRAPIHX>;
	Tue, 16 Jan 2001 03:07:23 -0500
Date: Tue, 16 Jan 2001 09:08:38 +0100
From: Bobo Rajec <bobo@bspc.sk>
To: linux-kernel@vger.kernel.org
Cc: daryll@users.sourceforge.net
Subject: 2.4.0 bug: file /proc/dri 4 times in ls listing
Message-ID: <20010116090838.A6283@bspc.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OriginalArrivalTime: 16 Jan 2001 08:07:51.0303 (UTC) FILETIME=[6BDE6170:01C07F93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm running kernel 2.4.0 on Redhat 7.0. I tried to get direct
rendering running (it failed, but that's another story). Today I
noticed something strange in /proc: dri appears there 4 times.

ls /proc:
...
-r--r--r--    1 root     root            0 Jan 16 08:57 dma
dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
dr-xr-xr-x    3 root     root            0 Jan 16 08:57 dri
dr-xr-xr-x    2 root     root            0 Jan 16 08:57 driver
...

Chdir /proc/dri/0 works fine:

bobo:/proc/dri/0>ls
bufs  clients  histo  mem  name  queues  vm  vma

No dri modules, everything is linked in (I know I don't need all of
these, but I have lots of memory, so...).

...
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_GAMMA=y
CONFIG_DRM_R128=y
CONFIG_DRM_I810=y
CONFIG_DRM_MGA=y
...

Regards,
	bobo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
