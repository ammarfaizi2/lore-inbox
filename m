Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUEaFpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUEaFpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 01:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUEaFpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 01:45:42 -0400
Received: from dns1.vodatel.hr ([217.14.208.29]:2518 "EHLO dns1.vodatel.hr")
	by vger.kernel.org with ESMTP id S264541AbUEaFpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 01:45:39 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko.ursulin@zg.htnet.hr>
To: linux-kernel@vger.kernel.org
Subject: Re: dma ripping
Date: Mon, 31 May 2004 07:19:04 +0200
User-Agent: KMail/1.6.2
Cc: Philip Dodd <phil.lists@two-towers.net>, Jens Axboe <axboe@suse.de>,
       Hugo Mills <hugo-lkml@carfax.org.uk>, Daniele Bernardini <db@sqbc.com>
References: <1084548566.12022.57.camel@linux.site> <20040520133437.GH1952@suse.de> <40BA1B9B.9070805@two-towers.net>
In-Reply-To: <40BA1B9B.9070805@two-towers.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405310719.04841.tvrtko.ursulin@zg.htnet.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> symptoms as before - ie. certain CDs will cause the "kernel: cdrom:
> dropping to single frame dma", and all ripping form that point on until
> reboot will just rip to silence (I have one test case that does it 75%
> of the way through track 4, as regular as clockwork, but several other

I have the same problem. Kernel is 2.6.6.

May 29 16:35:56 sol kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB 
Cache, UDMA(33)

Error:

May 29 16:13:32 sol kernel: cdrom: dropping to single frame dma

And after that I got some:

May 29 16:35:04 sol kernel: hdc: command error: error=0x54
May 29 16:35:04 sol kernel: end_request: I/O error, dev hdc, sector 0
May 29 16:35:04 sol kernel: Buffer I/O error on device hdc, logical block 0
May 29 16:35:04 sol kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }

Temporary solution was:

rmmod ide-cd
modprobe ide-cd

