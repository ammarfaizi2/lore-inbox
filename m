Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271941AbTHMXN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271972AbTHMXN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:13:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50063 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271941AbTHMXNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:13:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Niehusmann <jan@gondor.com>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Date: Thu, 14 Aug 2003 01:14:32 +0200
User-Agent: KMail/1.5
References: <20030806150335.GA5430@gondor.com> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813223641.GA1921@gondor.com>
In-Reply-To: <20030813223641.GA1921@gondor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308140114.32027.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 of August 2003 00:36, you wrote:
> On Wed, Aug 13, 2003 at 02:21:26AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Jan, did removing offending lines from pdc202xx_old.c help?
>
> Ok, now I tried a kernel without the
> "hwif->addressing = (hwif->channel) ? 0 : 1"  line in pdc202xx_old.c,
> and yes, now the 160GB drive works without aliasing parts above 137GB
> back to the beginning of the drive.
>
> Some simple tests (reading and writing a few 100MB of data) didn't show
> any nasty side effects. If you want me to do additional tests, please
> tell me. At the moment the drive doesn't contain any data, so I can even
> try dangerous things.

Thanks!  Can you do some more testing?
LBA-48 should be (was before 2.4.20 according to previous bugreports) working
just fine, but just to make sure.

I will remove these offending lines from 2.6.x if there are no problems.

--bartlomiej

