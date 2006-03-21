Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWCULgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWCULgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWCULgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:36:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030342AbWCULgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:36:04 -0500
Date: Tue, 21 Mar 2006 03:32:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, reiserfs@namesys.com
Subject: Re: Bug on unmounting in 2.6.16-rc6-mm2
Message-Id: <20060321033251.32ca71da.akpm@osdl.org>
In-Reply-To: <200603211219.14115@zodiac.zodiac.dnsalias.org>
References: <200603211219.14115@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> Hi,
> 
> when I shutdown (and umount) my system, I got a kernel bug:
> Screenshots:
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_001.jpg
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_002.jpg
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_003.jpg
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_004.jpg
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_005.jpg

heh, kernel porn.

> dmesg:
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/dmesg
> config:
> http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/config
> mount:
> moalex@t40:~$ mount
> /dev/hda6 on / type reiser4 (rw,noatime)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> usbfs on /proc/bus/usb type usbfs (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda2 on /boot type ext3 (ro,noatime)
> /dev/hda4 on /home type reiser4 (rw,noatime)
> /dev/hda7 on /files type ext3 (rw,noatime,commit=600)
> tmpfs on /dev type tmpfs (rw,size=10M,mode=0755)
> 
> Sorry for the inconvenience, but I've got no OCR at hand ;)

Better than nothing.

We've had a few clear_inode()-related crashes lately, but mainly
NFS-related.  This one looks more like a reiser4 thing though.

Is it reproducible?
