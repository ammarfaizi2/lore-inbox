Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTLPUNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTLPUNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:13:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25219 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262315AbTLPUNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:13:36 -0500
Date: Tue, 16 Dec 2003 15:16:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Kristofer T. Karas" <ktk@ENTERPRISE.BIDMC.HARVARD.EDU>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.24-pre1: Instant reboot
In-Reply-To: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu>
Message-ID: <Pine.LNX.4.53.0312161511350.21535@chaos>
References: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Kristofer T. Karas wrote:

> Hi Marcelo, et al,
>
> Just wanted to report an instantaneous reboot problem with 2.4.24-pre1.
>
> I don't even see any printk's to the screen; as soon as LILO is finished
> loading the new kernel, the screen blanks and the BIOS goes through its
> boot sequence again.  Since I seem to be the only one reporting this to
> LKML, I suspect I'll have to back out various patches to try to track
> this down. :-P
>
> I'm using the same .config as in 2.4.23 with new questions left at their
> defaults (e.g. XFS=n, OOM_KILLER=n).  I've had no problems with this
> otherwise rock-stable platform for all varieties of 2.4.x, save for some
> early USB EHCI issues long ago.
>
> At work now, so I don't have a full .config handy, but:
> * Slackware 8.1 based; glibc 2.2.5; gcc 2.95.3
> * Soltek SL-75DRV2 (UP, Athlon XP 1700, VIA KT266A [VT8366A/VT8233])
> * Root = ext3 on IDE partition
> * DevFS, DevPTS, IDE-SCSI=cdrom0, USBStorage, USB EHCI, VFAT
> * RadeonFB, IPTables, Realtek-8139
> Everything else in .config is pretty vanilla (e.g. Linus defaults or
> thereabouts).
>
> Kris
>

What CPU did you compile it for? The reboot stuff looks like
a CPU reset because of a triple fault, i.e., using CMOV when
there isn't any, etc. Try something more generic and see if
it boots.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


