Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVAHMFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVAHMFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 07:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAHMFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 07:05:39 -0500
Received: from [213.146.154.40] ([213.146.154.40]:60110 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261862AbVAHMF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 07:05:28 -0500
Date: Sat, 8 Jan 2005 12:05:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20050108120517.GA27414@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Al Viro <viro@ftp.uk.linux.org>, Jens Axboe <axboe@suse.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D3646F.5050408@drzeus.cx> <20041230095448.A9500@flint.arm.linux.org.uk> <41D4253D.8070006@drzeus.cx> <20050107123947.B23665@flint.arm.linux.org.uk> <20050107140035.GA5920@pclin040.win.tue.nl> <20050108110957.D7065@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108110957.D7065@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:09:57AM +0000, Russell King wrote:
> Your point 2 isn't user space though.
> 
> Also, it's buggy.  Consider a SCSI PCMCIA card with SCSI disks attached.
> When you eject that card, your SCSI disks disappear, yet they aren't
> marked as removable.  If user space is relying on /sys/block/*/removable
> to tell it if things may go away, then user space is buggy.

It means removable media.  The actual device can disappear for just about
any driver these days, considering pci hotplug or PCMCIA or usb or..

> Maybe it's for devices which may be present (eg, floppy driver), but
> which have removable media (eg, floppy disk), rather than removable
> devices?

Yes.  Else there would be very little driver that don't set the flag.

