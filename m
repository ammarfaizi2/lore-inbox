Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVBUCZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVBUCZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 21:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVBUCZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 21:25:53 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:14035 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261448AbVBUCZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 21:25:45 -0500
Message-ID: <421946A3.4090609@arrakis.dhis.org>
Date: Mon, 21 Feb 2005 02:25:39 +0000
From: Pedro Venda <pjvenda@arrakis.dhis.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help - really messed up kernel
References: <Pine.GSO.4.44.0502201516330.20265-200000@hornet>
In-Reply-To: <Pine.GSO.4.44.0502201516330.20265-200000@hornet>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Hudson wrote:
| I am trying to install linux on a laptop that cannot boot from cdrom.
| I got a stripped-down kernel to boot from floppy, ran lspci to get
| the hardware information.
|
| I then reconfigured and rebuilt the kernel for the image.
|
| I built this kernel from stock 2.6.10 from www.kernel.org.
| This is the configuration file. I then installed it on a floppy disk
| with syslinux, then tried to boot it.
|
| boot: vmlinuz root=/dev/fd0 load_ramdisk=1 prompt_ramdisk=1
| (my ramdisk is the next flooppy, this kernel is 1.3mb)
| Did not load the ramdisk.
| I got an error about unable to open root on "<NULL>" or device 22,6.
| Hmm. So, I ran rdev to set the kernel default root to /dev/fd0 and booted.
|
| Result: loaded the ramdisk, then complained about lack of a valid
| filesystem on /dev/fd0

you want to load your root filesystem into a ramdisk and use it from there.

your kernel command line is wrong. it should have root=/dev/rd/0 or
root=/dev/ram0 instead of root=/dev/fd0.

after loading the initrd, your root filesystem is on a ramdisk.

regards,
pedro venda.
- --

Pedro João Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCGUajeRy7HWZxjWERAm2iAJ4yQIEXp8gB3ltotJ229PZhQUsCcwCgxXtI
AHa+nWqajS299v+v09DoWCY=
=cEN1
-----END PGP SIGNATURE-----
