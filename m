Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313313AbSDQKyc>; Wed, 17 Apr 2002 06:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313330AbSDQKyb>; Wed, 17 Apr 2002 06:54:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14341 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313313AbSDQKy3>; Wed, 17 Apr 2002 06:54:29 -0400
Message-ID: <3CBD45BD.4040209@evision-ventures.com>
Date: Wed, 17 Apr 2002 11:51:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
> boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
> 
> 	if (drive->using_tcq) {
> 		int tag = ide_get_tag(drive);
> 
> 		BUG_ON(drive->tcq->active_tag != -1);

OK it could be that the tca goesn't get allocated if there
was no chipset selected. Lets have a look...


> 
> Relevant .config is
> # CONFIG_PCI is not set
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> (That's it. No chipset support selected; neither I nor Linux
> has ever detected any known IDE chipset in this box...)
> 
> Why is drive->using_tcq non-zero when CONFIG_BLK_DEV_IDE_TCQ=n
> and the disk is an early/mid-90s 500MB WD drive?
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

