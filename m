Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUAQRkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 12:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUAQRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 12:40:00 -0500
Received: from ns.suse.de ([195.135.220.2]:23936 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266071AbUAQRj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 12:39:58 -0500
To: Charles Shannon Hendrix <shannon@widomaker.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
References: <20040117031925.GA26477@widomaker.com>
	<20040117042208.GA8664@merlin.emma.line.org>
	<20040117154905.GB26248@widomaker.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'll eat ANYTHING that's BRIGHT BLUE!!
Date: Sat, 17 Jan 2004 18:36:08 +0100
In-Reply-To: <20040117154905.GB26248@widomaker.com> (Charles Shannon
 Hendrix's message of "Sat, 17 Jan 2004 10:49:05 -0500")
Message-ID: <jevfna5vg7.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Shannon Hendrix <shannon@widomaker.com> writes:

> Sat, 17 Jan 2004 @ 05:22 +0100, Matthias Andree said:
>
>> Interesting. I use dev=/dev/hdc and it works fine for me (Plextor 48X),
>> but then again, I'm also running the latest cdrecord alpha.
>
> % cdrecord -version
> Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
>
> I can try an alpha version, but from running strace on cdrecord, it
> seems like Linux is the problem.  Several ioctl() calls are failing just
> before cdrecord prints an error message and exits.

I see similar problems on ppc, with these messages in the log:

Jan 17 16:15:43 whitebox kernel: ide0, timeout waiting for dbdma command stop
Jan 17 16:15:43 whitebox kernel: ide-cd: dma error
Jan 17 16:15:43 whitebox kernel: hdb: DMA disabled
Jan 17 16:15:43 whitebox kernel: hdb: dma error: status=0x50 { DriveReady SeekComplete }
Jan 17 16:15:43 whitebox kernel: hdb: dma error: error=0x00
Jan 17 16:15:43 whitebox kernel: cdrom_newpc_intr: 180 residual after xfer

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
