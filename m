Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266516AbRGDHLw>; Wed, 4 Jul 2001 03:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266519AbRGDHLc>; Wed, 4 Jul 2001 03:11:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20750 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266516AbRGDHLU>; Wed, 4 Jul 2001 03:11:20 -0400
Subject: Re: [PATCH] 64 bit scsi read/write
To: bcrl@redhat.com (Ben LaHaise)
Date: Wed, 4 Jul 2001 08:11:27 +0100 (BST)
Cc: kernel@ragnark.vestdata.no (=?iso-8859-1?Q?Ragnar_Kj=F8rstad?=),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
In-Reply-To: <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com> from "Ben LaHaise" at Jul 03, 2001 10:19:36 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Hgop-0000Ve-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- lb-2.4.6-pre8/drivers/scsi/scsi.h	Tue Jul  3 01:31:47 2001
> +++ lb-2.4.6-pre8.scsi/drivers/scsi/scsi.h	Tue Jul  3 22:03:16 2001
> @@ -351,7 +351,7 @@
>  #define DRIVER_MASK         0x0f
>  #define SUGGEST_MASK        0xf0
> 
> -#define MAX_COMMAND_SIZE    12
> +#define MAX_COMMAND_SIZE    16

Please talk to Khalid at HP who has already submitted patches to handle
16 byte comamnd blocks on some controllers cleanly. I think you need to
combine both patches to get the right result

> +	if (SCpnt->device->sixteen) {

[and controller]

Alan

