Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271312AbTHMWkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271327AbTHMWkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:40:46 -0400
Received: from mail.gondor.com ([212.117.64.182]:14349 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S271312AbTHMWkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:40:45 -0400
Date: Thu, 14 Aug 2003 00:36:41 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813223641.GA1921@gondor.com>
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

Ok, now I tried a kernel without the 
"hwif->addressing = (hwif->channel) ? 0 : 1"  line in pdc202xx_old.c,
and yes, now the 160GB drive works without aliasing parts above 137GB
back to the beginning of the drive.

Some simple tests (reading and writing a few 100MB of data) didn't show
any nasty side effects. If you want me to do additional tests, please
tell me. At the moment the drive doesn't contain any data, so I can even
try dangerous things.

Jan

