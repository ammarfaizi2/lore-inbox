Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUE0WJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUE0WJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUE0WJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 18:09:54 -0400
Received: from host171.155.212.251.conversent.net ([155.212.251.171]:32525
	"EHLO actuality-systems.com") by vger.kernel.org with ESMTP
	id S265508AbUE0WJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 18:09:38 -0400
Subject: Re: Can't make XFS work with 2.6.6
From: David Aubin <daubin@actuality-systems.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200405271925.24650.dj@david-web.co.uk>
References: <200405271736.08288.dj@david-web.co.uk>
	 <200405271854.20787.dj@david-web.co.uk> <1085680806.5311.44.camel@buffy>
	 <200405271925.24650.dj@david-web.co.uk>
Content-Type: text/plain
Message-Id: <1085695702.10106.65.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 27 May 2004 18:08:23 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2004 22:08:05.0140 (UTC) FILETIME=[15B6AD40:01C44437]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

  You do not have devfs enabled.  So root=/dev/hda3
should not work.  Please enable in kernel and retry.

# CONFIG_DEVFS_FS is not set

Dave

On Thu, 2004-05-27 at 14:25, David Johnson wrote:
> On Thursday 27 May 2004 19:00, David Aubin wrote:
> > Hi Dave,
> >
> >   Please include the latest copy of your .config.
> 
> Attached.
> 
> > Also the boot loader parameter as well.  
> 
> >From Grub's menu.lst:
> 
> title		Debian GNU/Linux, kernel 2.6.6
> root		(hd0,0)
> kernel	/vmlinuz-2.6.6 lapic video=rivafb:mode:1024x768x16 root=/dev/hda3 ro
> initrd		/initrd.img-2.6.6
> savedefault
> boot
> 
> > And possibly 
> > the validation that the root partition is of type XFS?
> 
> Here's the mount output from the system running a 2.4 kernel:
> 
> lug:/tmp# mount
> /dev/hda3 on / type xfs (rw)
> proc on /proc type proc (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/hda1 on /boot type ext3 (rw)
> /dev/hda2 on /home type xfs (rw)
> /dev/sda2 on /var type xfs (rw)
> usbfs on /proc/bus/usb type usbfs (rw)
> 
> >   At a glance it appears that XFS is not compilied in to
> > your kernel now, if that is your root mount file type.
> 
> XFS is compiled in. I really don't know what else to try...
> 
> Thanks,
> David.

