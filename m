Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUFNIQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUFNIQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUFNIQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:16:27 -0400
Received: from [213.146.154.40] ([213.146.154.40]:24017 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262071AbUFNIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:14:03 -0400
Date: Mon, 14 Jun 2004 09:14:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [7/12] Handle NO_SENSE in sd_rw_intr in sd.c
Message-ID: <20040614081401.GF7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004034.GV1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:40:34PM -0700, William Lee Irwin III wrote:
>  * Handle NO_SENSE in sd_rw_intr in drivers/scsi/sd.c (Alan Stern)
> This fixes Debian BTS #232494.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=232494
> 
> 	Message-ID: <402C7AEF.6030206@post.cz>
> 	From: =?windows-1252?Q?Tonda_M=ED=9Aek?= <tonda.misek@post.cz>
> 	To: submit@bugs.debian.org
> 	Subject: mount not work for usb-storage with vfat
> 
> I have unstable Debian distribution.
> The usb-storage device is USB flash disk.
> 
> mount -t vfat /dev/sda1 /ahd/
> 
> mount: /dev/sda1: can't read superblock
> SCSI error: <1 0 0 0> return code 0x8000000
> Current sda: sense key No sense
> end_request: I/O error, dev sda, sector 32
> FAT: unable to read boot sector
> 
> Moreover vfat driver not recognize mount option "isocharset=iso8859-2" 
> at all.
> 
> With kernel 2.4.24 all works without problems


James didn't like this version of the patch but I sent him one addressing his
concerns.  Again linux-scsi is the right list for this.

