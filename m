Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSAFWAS>; Sun, 6 Jan 2002 17:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282523AbSAFWAH>; Sun, 6 Jan 2002 17:00:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289045AbSAFV76>;
	Sun, 6 Jan 2002 16:59:58 -0500
Message-ID: <3C38C8DA.1FE44A47@mandrakesoft.com>
Date: Sun, 06 Jan 2002 16:59:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: ajoshi@shell.unixbox.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] A very little patch to make rivafb to be compiled
In-Reply-To: <20020106160225.5c080f76.johnpol@2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> 
> Hello, Ani Joshi and other hackers.
> 
> Here is patch against 2.5.2-pre9 wich make rivafb to be compiled:
> 
> --- /usr/src/linux-2.5.2-pre/drivers/video/riva/fbdev.c~        Wed Nov 14
> 17:52:20 2001
> +++ /usr/src/linux-2.5.2-pre/drivers/video/riva/fbdev.c Sun Jan  6
> 15:45:04 2002
> @@ -1811,7 +1811,7 @@
>         info = &rinfo->info;
> 
>         strcpy(info->modename, rinfo->drvr_name);
> -       info->node = -1;
> +       info->node = to_kdev_t(-1);
>         info->flags = FBINFO_FLAG_DEFAULT;
>         info->fbops = &riva_fb_ops;

This should be assigned to "NODEV" not "to_kdev_t(-1)".

Several fbdev drivers need this change.

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
