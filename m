Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289962AbSAPPXF>; Wed, 16 Jan 2002 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289967AbSAPPWy>; Wed, 16 Jan 2002 10:22:54 -0500
Received: from gw.wmich.edu ([141.218.1.100]:10442 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289962AbSAPPWk>;
	Wed, 16 Jan 2002 10:22:40 -0500
Message-ID: <002c01c19ea1$ea0c9160$0501a8c0@psuedogod>
From: "Ed Sweetman" <ed.sweetman@wmich.edu>
To: "Lukas Geyer" <geyer@ml.kva.se>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Date: Wed, 16 Jan 2002 10:24:30 -0500
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

> Hi,
>
> I am very glad that the PPC patches are now merged so I can use a
> mainstream kernel again on my iBook. Thanks to all the people who did
> this. It works quite fine so far but there are two minor problems:
>
> - The kernel ignores the boot parameter hdb=ide-scsi, it probes hdb anyway
>   and loads the ATAPI CD-ROM driver. The problem may be (I am really not
>   familiar with the kernel internals) the function pmac_ide_probe() in
>   drivers/ide/ide-pmac.c which does not check for any kernel boot
>   parameters at all.
This has beed changed for some time now.  You need to pass some ignore
argument to the ide-cdrom driver and load it first then load the ide-scsi
which will detect any remaining atapi devices.  I could give you the exact
line if my system wasn't dead at the moment.



