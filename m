Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKUW0w>; Tue, 21 Nov 2000 17:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbQKUW0c>; Tue, 21 Nov 2000 17:26:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62735 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129208AbQKUW0Z>;
	Tue, 21 Nov 2000 17:26:25 -0500
Message-ID: <3A1AEF5A.C141C5F3@mandrakesoft.com>
Date: Tue, 21 Nov 2000 16:55:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: torvalds@transmeta.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] fix IDE/ServerWorks OSB4 config option (test11)
In-Reply-To: <Pine.LNX.4.21.0011211522570.4622-100000@tricky>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> --- linux-240t11/drivers/ide/Config.in  Wed Nov 15 22:02:11 2000
> +++ linux/drivers/ide/Config.in Tue Nov 21 14:52:07 2000
> @@ -68,7 +68,7 @@
>             dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
>             dep_bool '    PROMISE PDC20246/PDC20262/PDC20267 support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
>             dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
> -           dep_bool '    ServerWorks OSB4 chipset support' CONFIG_BLK_DEV_OSB4 $CONFIG_BLK_DEV_OSB4
> +           dep_bool '    ServerWorks OSB4 chipset support' CONFIG_BLK_DEV_OSB4 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
>             dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
>             dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86


Just wondering, why do these depend on CONFIG_X86?

I just glanced at osb4.c and it looks pretty well-written and portable
to me...  Nothing X86 specific about it.  Ditto some of the others
depending on CONFIG_X86.  IMHO even if the southbridge is currently only
known to be used on x86's, that doesn't mean that the hardware, or the
driver, will always be limited to the X86 platform.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
