Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTKHA2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKGWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:46 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:32966 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S263986AbTKGJiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:38:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=/dev/hdd in 2.9.0-test9-mm2: lots (LOTS) of error messages
Date: Fri, 7 Nov 2003 04:37:59 -0500
User-Agent: KMail/1.5.1
References: <20031106134314.GA3282@middle.of.nowhere>
In-Reply-To: <20031106134314.GA3282@middle.of.nowhere>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311070437.59591.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.62.77] at Fri, 7 Nov 2003 03:38:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 08:43, Jurriaan wrote:
>I tried to burn a CD using this command-line in 2.6.0-test9-mm2:
>
The as scheduler in test9-mm2 is a bit fubar, reboot after adding 
"elevator=deadline" to the kernel options in grub.conf.
With the exception of an occasional ac97 message, the logs are now 
clean, and the mouse is much smoother.

>sudo cdrecord -v dev="/dev/hdd" -dao -useinfo *.wav
>
>Result:
>
>[this about 5 times per second]
>Nov  6 14:37:17 middle kernel: arq->state 4
>Nov  6 14:37:17 middle kernel: Badness in as_put_request at
> drivers/block/as-iosched.c:1783 Nov  6 14:37:17 middle kernel: Call
> Trace:
>Nov  6 14:37:17 middle kernel:  [scsi_host_dev_release+0/144]
> as_put_request+0x60/0xc0 Nov  6 14:37:17 middle kernel: 
> [cdrom_buffer_sectors+62/192] elv_put_request+0x1e/0x20 Nov  6
> 14:37:17 middle kernel:  [ide_cdrom_audio_ioctl+197/416]
> __blk_put_request+0x65/0xb0 Nov  6 14:37:17 middle kernel: 
> [ide_cdrom_audio_ioctl+319/416] blk_put_request+0x2f/0x50 Nov  6
> 14:37:17 middle kernel:  [ide_release_iomio_dma+40/144]
> sg_io+0x2f8/0x450 Nov  6 14:37:17 middle kernel: 
> [ide_setup_dma+746/880] scsi_cmd_ioctl+0x25a/0x4f0 Nov  6 14:37:17
> middle kernel:  [cfq_init+330/368] opost_block+0x11a/0x1e0 Nov  6
> 14:37:17 middle kernel:  [copy_process+2666/2864]
> default_wake_function+0x2a/0x30 Nov  6 14:37:17 middle kernel: 
> [make_request+288/624] cdrom_ioctl+0x30/0xe90 Nov  6 14:37:17
> middle kernel:  [sys_rt_sigtimedwait+61/880] do_timer+0xdd/0xf0 Nov
>  6 14:37:17 middle kernel:  [default_pins3+79/80]
> idecd_ioctl+0x5f/0x70 Nov  6 14:37:17 middle kernel: 
> [ide_hwif_configure+364/448] blkdev_ioctl+0x8c/0x3c0 Nov  6
> 14:37:17 middle kernel:  [kernel_fpu_begin+26/64]
> do_gettimeofday+0x2a/0xc0 Nov  6 14:37:17 middle kernel: 
> [__d_lookup+84/336] sys_ioctl+0xf4/0x270 Nov  6 14:37:17 middle
> kernel:  [__func__.4+169072/376069] syscall_call+0x7/0xb

[...]

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

