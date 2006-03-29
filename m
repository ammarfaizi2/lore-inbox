Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWC2HS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWC2HS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWC2HS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:18:26 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:15251 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWC2HS0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:18:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gD7HcJUuh8q6a1CUVddHz9ovIq1NCrjXYnBuuR7hzrCK62La4FtQF6duIrV1A4J0ed/BkW+qS0r0x9ItiuV+61XpudlirFkkQPySiQVt5QWN5W7uqQkRyrG2aii8hfWsHTtWCuA7aBhNtv+iTeHwkHg9qUvALIRFC08RSYnow8g=
Message-ID: <58cb370e0603282318t1b74c40cx6a173b3561c3fa54@mail.gmail.com>
Date: Wed, 29 Mar 2006 09:18:25 +0200
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [PATCH -mm 4/4] LED: Add IDE disk activity LED trigger
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1143591445.14682.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1143591445.14682.60.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> Add an LED trigger for IDE disk activity to the ide-disk driver.
>
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
>
> Index: linux-2.6.16/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/ide/ide-disk.c    2006-03-28 17:22:51.000000000 +0100
> +++ linux-2.6.16/drivers/ide/ide-disk.c 2006-03-28 17:25:12.000000000 +0100
> @@ -60,6 +60,7 @@
>  #include <linux/genhd.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>
>  #define _IDE_DISK
>
> @@ -316,6 +317,8 @@
>                 return ide_stopped;
>         }
>
> +       ledtrig_ide_activity();
> +

Now this is really non-intrusive. :)
Thank you for reworking the patch.

The rest of changes also look fine for me, ACK.

Bartlomiej
