Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSIBGhM>; Mon, 2 Sep 2002 02:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSIBGhM>; Mon, 2 Sep 2002 02:37:12 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:54540 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S317462AbSIBGhM>; Mon, 2 Sep 2002 02:37:12 -0400
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
In-Reply-To: <1030911578.17142.1.camel@odysseus.mittagstun.de>
To: Martin Wilck <mwilck@freenet.de>
Date: Mon, 2 Sep 2002 08:41:13 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, Greg KH <greg@kroah.com>,
       marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17lktd-0001R2-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Don, 2002-08-29 um 15.57 schrieb Marek Michalkiewicz:
> > > > /* aka Sagatek DCS-CF */
> > > > UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> > > > 		"Datafab",
> > > > 		"KECF-USB",
> > > > 		US_SC_SCSI, US_PR_BULK, NULL,
> > > > 		US_FL_FIX_INQUIRY ),
> 
> This works fine with 2.4.20 - congratulations!!
> I wonder what happened to the SCSI inquiry - was it limited to 36 bytes?

My understanding is that US_FL_FIX_INQUIRY flag fakes a response
without sending the SCSI inquiry to the device at all.

What revision number does your device have, so we can limit the range
(mine is 0113)?  How about US_FL_MODE_XLATE and US_FL_START_STOP -
how to test if these flags are necessary?

Thanks,
Marek

