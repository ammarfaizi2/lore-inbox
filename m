Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSBEXCD>; Tue, 5 Feb 2002 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289837AbSBEXBx>; Tue, 5 Feb 2002 18:01:53 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:37143 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S289836AbSBEXBn>; Tue, 5 Feb 2002 18:01:43 -0500
Message-ID: <002f01c1ae96$143af4a0$0501a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Ralf Oehler" <R.Oehler@GDAmbH.com>, "Scsi" <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "Andrea Arcangeli" <andrea@suse.de>, "Jens Axboe" <axboe@kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Date: Tue, 5 Feb 2002 22:40:14 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, List
>
> I think, I found a very simple solution for this annoying BUG().
>
> Since at least kernel 2.4.16 there is a BUG() in pci.h,
> that crashes the kernel on any attempt to read a SCSI-Sector
> from an erased MO-Medium and on any attempt to read
> a sector from a SCSI-disk, which returns "Read-Error".
>
> There seems to be a thinko in the corresponding code, which
> does not take into account the case where a SCSI-READ
> does not return any data because of a "sense code: read error"
> or a "sense code: blank sector".
>

would this also happen with the ide-scsi driver then
and would this explain why i see panic's on when reading
cd's ?


    James


