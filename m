Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUG1EbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUG1EbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 00:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUG1EbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 00:31:12 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:55721 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S266775AbUG1Eax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 00:30:53 -0400
Subject: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 27 Jul 2004 21:30:52 -0700
Message-Id: <1090989052.3098.6.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens -

I'm having trouble reading a DVD or CD image from an ATAPI drive that
identifies itself as a 'LITEON DVD-ROM LTD163D'.  This is with vanilla
2.6.7 on a system running Fedora Core 2.

Regardless of what I do, I get the same errors:

        Jul 27 21:18:30 camp4 kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
        Jul 27 21:18:30 camp4 kernel: hdc: command error: error=0x54
        Jul 27 21:18:30 camp4 kernel: end_request: I/O error, dev hdc, sector 837264
        Jul 27 21:18:30 camp4 kernel: Buffer I/O error on device hdc, logical block 104658

I have ide-cd compiled as a module.  This occurs whether or not ide-cd
is loaded (I don't have ide-scsi enabled), and whether or not I have DMA
turned on.

I don't believe there is anything wrong with the drive, as it used to
work OK on 2.4, 2.5, and early 2.6 kernels, and I believe the media to
be fine, as the disk in question plays back on a Mac and a DVD player.

Googling for "error=0x54", I see a lot of reports of this kind of
problem, but never with any resolutions, so I'm stumped.  Is there any
information I can give you that would help?

Thanks,

	<b

