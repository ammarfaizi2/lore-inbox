Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271687AbTHMIFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTHMIFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:05:21 -0400
Received: from mail.gondor.com ([212.117.64.182]:60935 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S271687AbTHMIFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:05:17 -0400
Date: Wed, 13 Aug 2003 10:03:09 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813080309.GB2006@gondor.com>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308130221.26305.bzolnier@elka.pw.edu.pl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 02:21:26AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Jan, did removing offending lines from pdc202xx_old.c help?

I do not want to try it on our server, but I have a similar mainboard
and just bought a 160GB harddisk to try it on another computer.

Unfortunately, it doesn't seem to work well. The hard disk only gives
20MB/s on sequential read (Seagate Baraccuda 160GB should be faster,
right?), and hdparm -I /dev/hde completely locks up the whole computer -
no console message at all, only hard reset helps. I need to get this
running before I can try kernel patches for the LBA48 stuff.

By the way: That computer reports a
00:11.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
while the server has a 
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)

(Numeric Class IDs are 0104 and respectively 0180, vendor and device 
codes are the same on both computers)

Do you think this will make any difference? IIRC, the FastTrack series
has some RAID features, but you can safely ignore them and use it
just as a simple ATA100 controller.

Jan

