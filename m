Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbTL3JKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTL3JKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:10:21 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:62098 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265700AbTL3JKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:10:11 -0500
Date: Tue, 30 Dec 2003 10:10:10 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031230101010.A14772@beton.cybernet.src>
References: <20031229173853.A32038@beton.cybernet.src> <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com> <20031229183302.B32137@beton.cybernet.src> <20031229174951.GA304@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229174951.GA304@louise.pinerecords.com>; from szepe@pinerecords.com on Mon, Dec 29, 2003 at 06:49:51PM +0100
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 06:49:51PM +0100, Tomas Szepe wrote:
> On Dec-29 2003, Mon, 18:33 +0100
> Karel Kulhavý <clock@twibright.com> wrote:
> 
> > > You'll need to load the usb modules using initrd ramdisk, then switch root
> > > to the usb device to continue booting the system.
> > 
> > This is the problem #2. I am not able to remount /. "device or resource busy".
> > How do I remount the "/"?
> 
> /sbin/mount -o remount,rw /

bash-2.05b# mount
/dev/hda4 on / type xfs (rw)
none on /dev type devfs (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw)
/dev/hda1 on /boot type ext2 (rw,noatime)
none on /dev/shm type tmpfs (rw)
bash-2.05b# mount -o remount,rw /dev/sda1 /
bash-2.05b# mount
/dev/hda4 on / type xfs (rw)
^^^^^^^^^
none on /dev type devfs (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw)
/dev/hda1 on /boot type ext2 (rw,noatime)
none on /dev/shm type tmpfs (rw)

bash-2.05b# mount --version
mount: mount-2.12
bash-2.05b# cat /proc/version
Linux version 2.6.0 (root@oberon) (gcc version 3.3.2 20031022 (Gentoo Linux
3.3.2-r3, propolice)) #4 Mon Dec 29 12:20:39 MET 2003

When doing find / after that, the IDE disk goes crazy, not the USB one.
So that mount doesn't lie and nothing is really remounted (and no
error message issued). Is this how things are supposed to work?

Cl<
