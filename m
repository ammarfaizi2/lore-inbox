Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUG1FbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUG1FbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 01:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUG1FbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 01:31:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10156 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265654AbUG1FbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 01:31:12 -0400
Date: Wed, 28 Jul 2004 07:31:08 +0200
From: Jens Axboe <axboe@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040728053107.GB11690@suse.de>
References: <1090989052.3098.6.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090989052.3098.6.camel@camp4.serpentine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27 2004, Bryan O'Sullivan wrote:
> Hi, Jens -
> 
> I'm having trouble reading a DVD or CD image from an ATAPI drive that
> identifies itself as a 'LITEON DVD-ROM LTD163D'.  This is with vanilla
> 2.6.7 on a system running Fedora Core 2.
> 
> Regardless of what I do, I get the same errors:
> 
>         Jul 27 21:18:30 camp4 kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
>         Jul 27 21:18:30 camp4 kernel: hdc: command error: error=0x54
>         Jul 27 21:18:30 camp4 kernel: end_request: I/O error, dev hdc, sector 837264
>         Jul 27 21:18:30 camp4 kernel: Buffer I/O error on device hdc, logical block 104658
> 
> I have ide-cd compiled as a module.  This occurs whether or not ide-cd
> is loaded (I don't have ide-scsi enabled), and whether or not I have DMA
> turned on.
> 
> I don't believe there is anything wrong with the drive, as it used to
> work OK on 2.4, 2.5, and early 2.6 kernels, and I believe the media to
> be fine, as the disk in question plays back on a Mac and a DVD player.
> 
> Googling for "error=0x54", I see a lot of reports of this kind of
> problem, but never with any resolutions, so I'm stumped.  Is there any
> information I can give you that would help?

When does this happen - during kernel load, or during run of init
scripts?

-- 
Jens Axboe

