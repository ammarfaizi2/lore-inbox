Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTB1HlA>; Fri, 28 Feb 2003 02:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTB1HlA>; Fri, 28 Feb 2003 02:41:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:36806 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267581AbTB1Hk7> convert rfc822-to-8bit; Fri, 28 Feb 2003 02:40:59 -0500
From: Wolfgang =?iso-8859-1?q?M=FCes?= <wolfgang@iksw-muees.de>
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] 2.4.21-pre5: fix Auerswald compile
Date: Fri, 28 Feb 2003 08:47:41 +0100
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva> <20030227232612.GV7685@fs.tum.de>
In-Reply-To: <20030227232612.GV7685@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302280847.41981.wolfgang@iksw-muees.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

On Friday 28 February 2003 00:26, Adrian Bunk wrote:

> auerdev_table and auerdev_table_mutex are static in auermain.c but used
> from auerchar.c. The following patch makes them non-static:

You are right. This is a leftover from the old days where auermain and
auerchar function were both in auermain.c.

I wonder why I never get this error? Are you using a newer toolchain?
My gcc is version 2.95.3.

Greg, would you apply this patch?

best regards
Wolfgang Mües

>
> --- linux-2.4.21-pre5-full/drivers/usb/auermain.c.old	2003-02-28
> 00:15:45.000000000 +0100 +++
> linux-2.4.21-pre5-full/drivers/usb/auermain.c	2003-02-28 00:20:49.000000000
> +0100 @@ -66,10 +66,10 @@
>  extern devfs_handle_t usb_devfs_handle;
>
>  /* array of pointers to our devices that are currently connected */
> -static struct auerswald *auerdev_table[AUER_MAX_DEVICES];
> +struct auerswald *auerdev_table[AUER_MAX_DEVICES];
>
>  /* lock to protect the auerdev_table structure */
> -static struct semaphore auerdev_table_mutex;
> +struct semaphore auerdev_table_mutex;
>
>  /*-------------------------------------------------------------------*/
>  /* Forwards */
>
>
> cu
> Adrian

