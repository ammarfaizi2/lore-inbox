Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSAUSvw>; Mon, 21 Jan 2002 13:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSAUSvd>; Mon, 21 Jan 2002 13:51:33 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:18655
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287816AbSAUSvX>; Mon, 21 Jan 2002 13:51:23 -0500
Message-ID: <040501c1a2ad$534f9190$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Borsenkow Andrej" <Andrej.Borsenkow@mow.siemens.ru>,
        "linux-kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1011521234.2526.7.camel@localhost.localdomain>
Subject: Re: Query removable drives (CD-ROMs, flopies etc) for media presence
Date: Mon, 21 Jan 2002 11:56:25 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have working media change (and presense) detection for the ide-floppy
driver, that handles nearly every situation. It will be even better (and
handle all situations) when Andre's new IDE driver gets merged into 2.4.x
and I can use taskfile I/O to implement some more drive features.

The code is ready to be reviewed, I've asked Paul Bristow to do so but so
far haven't gotten any response.

----- Original Message -----
From: "Borsenkow Andrej" <Andrej.Borsenkow@mow.siemens.ru>
To: "linux-kernel list" <linux-kernel@vger.kernel.org>
Sent: Sunday, January 20, 2002 3:07 AM
Subject: Query removable drives (CD-ROMs, flopies etc) for media presence


> Is there reliable way to query drives for media presence? I have tried
> query_disk_change but it returns 1 if called without media inserted (it
> correctly works if media is present when it is called). I need it for
> CD-ROMs (IDE or SCSI) and possibly for other drives with removable media
> like floppy, Zip, Jaz.
>
> So far I tried with two IDE CD-ROMs and floppy and all show the same -
> query_disk_change always 1 when no media is present.
>
> The reason is I'd like to avoid media access when it is known no media
> is present. The kernel is 2.4.17.
>
> TIA
>
> -andrej
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

