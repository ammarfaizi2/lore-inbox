Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131579AbRCSTlK>; Mon, 19 Mar 2001 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131580AbRCSTlA>; Mon, 19 Mar 2001 14:41:00 -0500
Received: from smtp1.sentex.ca ([199.212.134.4]:26886 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S131579AbRCSTkm>;
	Mon, 19 Mar 2001 14:40:42 -0500
Message-ID: <3AB65F14.26628BEF@coplanar.net>
Date: Mon, 19 Mar 2001 14:33:41 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Moore <timothymoore@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Moore wrote:

> quintaq@yahoo.co.uk wrote:
> > I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.
> > ...
> > My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec.  I achieve this when DMA is enabled, - without it I fall back to about 5 Mb /sec.  No amount of fiddling with other hdparm settings makes any difference.
> > ...
>
> 15MB/s for hdparm is about right.

Yes, since hdparm -t measures *SUSTAINED* transfers... the actual "head rate" of data reads from
disk surface.  Only if you read *only* data that is alread in harddrive's cache will you get a speed
close to the UDMA mode of the drive/controller.  The cache is around 1Mbyte, so for a split-second
re-read of some data....

>
>
> "...four IDE devices can be supported in Bus Master mode.
>  PIIX4 contains support for "Ultra DMA/33" synchronous DMA
>  compatible devices."
>
> http://developer.intel.com/design/intarch/techinfo/440BX/PIIX4_intro.htm
>
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

