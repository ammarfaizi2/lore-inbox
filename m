Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWAWJLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWAWJLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWAWJLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:11:02 -0500
Received: from relay03.pair.com ([209.68.5.17]:46346 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751449AbWAWJLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:11:01 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: OOM Killer killing whole system
Date: Mon, 23 Jan 2006 03:10:33 -0600
User-Agent: KMail/1.9
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Titov <a.titov@host.bg>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <1137337516.11767.50.camel@localhost> <20060123083939.GB12773@suse.de> <1138005718.2977.22.camel@laptopd505.fenrus.org>
In-Reply-To: <1138005718.2977.22.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230310.56047.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 02:41, Arjan van de Ven wrote:
> > Just a note - you seem to have the raid1 in common with the rest of the
> > reporters so far.
>
> time to get out some of the obvious heavy hitters.. and enable slab
> debug and CONFIG_DEBUG_PAGEALLOC just with the chance to catch a random
> scribble of sorts

Will do this tomorrow. Please note that md1 is only used on the 
unmounted /boot filesystem. mount says:

turbotaz linux # mount
/dev/md/1 on / type reiserfs (rw,noatime)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
udev on /dev type tmpfs (rw,nosuid)
devpts on /dev/pts type devpts (rw)
shm on /dev/shm type tmpfs (rw,noexec,nosuid,nodev)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
usbfs on /proc/bus/usb type usbfs (rw,devmode=0664,devgid=85)

/dev/md/1 is raid10.

Cheers,
Chase
