Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUFFKiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUFFKiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 06:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUFFKiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 06:38:46 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:19418 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263226AbUFFKio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 06:38:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Sun, 6 Jun 2004 20:38:30 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       der.eremit@email.de
References: <200406060007.10150.kernel@kolivas.org> <20040606092825.GD2733@suse.de>
In-Reply-To: <20040606092825.GD2733@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406062038.31045.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004 19:28, Jens Axboe wrote:
> On Sun, Jun 06 2004, Con Kolivas wrote:
> > Well since 2.6.3 I think I've been getting the record number of
> >
> > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > hdd: status error: error=0x00
> > hdd: drive not ready for command
> > hdd: ATAPI reset complete
> >
> > errors from my cdrw on hdd; and it's only one drive's worth.
> >
> >
> > dmesg -s 32768 | grep DataRequest | wc -l
> > 88
> >
> > Note the -s 32768 is because my dmesg is so long due to the massive
> > number of seekcomplete errors :-)
> >
> > Since the cdrw works fine after re-enabling dma I never really
> > bothered to do anything about it, but I'm just curious if anyone has a
> > higher record ;-)
>
> Interesting, and 2.6.2 works flawlessly? The only change in 2.6.3 wrt
> ide-cd is the addition of the != 2kB sector size support from Pascal
> Schmidt. A quick guess would be that blocklen isn't set, does this
> change anything for you?

Sorry, it didn't help, but thanks for the suggestion.

Con

P.S. Terribly sorry about the way I reported this bug; Although I originally 
thought it was funny I think it was quite rude in retrospect.
