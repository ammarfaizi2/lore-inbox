Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUKCJ3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUKCJ3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUKCJXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:23:32 -0500
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:6893 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261546AbUKCJW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:22:57 -0500
Date: Wed, 3 Nov 2004 10:22:42 +0100 (CET)
From: Pawel Sikora <pluto@pld-linux.org>
X-X-Sender: pld@plus.ds14.agh.edu.pl
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Jens Axboe <axboe@suse.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
In-Reply-To: <41889EB5.3060304@tequila.co.jp>
Message-ID: <Pine.LNX.4.60.0411031017250.17288@plus.ds14.agh.edu.pl>
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de>
 <41889EB5.3060304@tequila.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Clemens Schwaighofer wrote:

> but I am ...
>
> I haven't tried to write a CD, but DVD is definilty not possible,
> because the device is _not_ listed in k3b if started as user. The
> internal CD writer is, so probably I can write here, because before,
> this wasn't even listed ...

Hi,

I have a NEC's DVD writer and it works.

[1] /var/log/dmesg
(...)
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
(...)

[2] modprobe ide_cd
(...)
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
(...)

[3] k3b lists it and works.

# uname -a
Linux vmx 2.6.10 #1 Fri Oct 29 19:24:27 CEST 2004 i686
                     Celeron_(Coppermine) unknown PLD Linux
# groups
users disk wheel proc audio video
# la /dev/hdc*
brw-rw----  1 root disk 22,  0 2004-07-16 08:16 /dev/hdc
