Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVBXRTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVBXRTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVBXRTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:19:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:56509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262420AbVBXRTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:19:09 -0500
Date: Thu, 24 Feb 2005 09:18:56 -0800
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-ID: <20050224171856.GB9439@kroah.com>
References: <20050223014233.6710fd73.akpm@osdl.org> <421C7FC2.1090402@aitel.hist.no> <20050223121207.412c7eeb.akpm@osdl.org> <421D0582.9090100@free.fr> <20050223234720.GA7270@kroah.com> <421E099F.1030104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E099F.1030104@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 06:06:39PM +0100, Laurent Riffard wrote:
> 
> 
> Le 24.02.2005 00:47, Greg KH a ?crit :
> >On Wed, Feb 23, 2005 at 11:36:50PM +0100, Laurent Riffard wrote:
> >
> >>hey, what's this /dev/hds ? digging into /sys/block...
> >>
> >>~$ ls -l  /sys/block/hds/device
> >>lrwxrwxrwx  1 root root 0 f?v 23 22:45 /sys/block/hds/device ->
> >>../../devices/pci0000:00/0000:00:04.1/ide1/1.1/
> >>
> >>/dev/hdq should be /dev/hdd...
> >>
> >>~$ ls -l /proc/ide
> >>total 4
> >>-r--r--r--  1 root root 0 f?v 23 23:28 drivers
> >>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hda -> ide0/hda/
> >>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdb -> ide0/hdb/
> >>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdc -> ide1/hdc/
> >>lrwxrwxrwx  1 root root 8 f?v 23 23:28 hdd -> ide1/hdd/
> >>dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide0/
> >>dr-xr-xr-x  4 root root 0 f?v 23 23:28 ide1/
> >>-r--r--r--  1 root root 0 f?v 23 23:28 via
> >>~$ ls -d /sys/block/hd*
> >>/sys/block/hda/  /sys/block/hdc/  /sys/block/hdq/  /sys/block/hds/
> >
> >
> >What does /proc/devices show?
> 
> Character devices:
>   1 mem
>   4 /dev/vc/0
>   4 tty
>   5 /dev/tty
>   5 /dev/console
>   5 /dev/ptmx
>   6 lp
>   7 vcs
>  10 misc
>  13 input
>  14 sound
>  29 fb
> 116 alsa
> 128 ptm
> 136 pts
> 171 ieee1394
> 180 usb
> 
> Block devices:
>   1 ramdisk
>   2 fd
>   3 ide0
>   7 loop
>  22 ide1
> 253 pktcdvd
> 254 device-mapper
> 
> Do you see something strange here  ?

No, ide0 is 3 and ide1 is 22, which is "standard".  Hm, what's that
pktcdvd and device-mapper doing there?  Do you need those drivers?  Can
you try it without building them and see if that helps?

thanks,

greg k-h
