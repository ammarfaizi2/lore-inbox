Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTH2VGC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTH2VGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:06:02 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:46557 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261674AbTH2VF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:05:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
Date: Fri, 29 Aug 2003 23:06:18 +0200
User-Agent: KMail/1.5.1
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
References: <pV54.523.43@gated-at.bofh.it> <20030829204017.GA2580@kroah.com> <20030829205034.GA2649@kroah.com>
In-Reply-To: <20030829205034.GA2649@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308292306.18178.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 22:50, Greg KH wrote:
> diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
> --- a/drivers/usb/core/file.c   Fri Aug 29 13:49:19 2003
> +++ b/drivers/usb/core/file.c   Fri Aug 29 13:49:20 2003
> @@ -129,7 +129,7 @@
>         int retval = -EINVAL;
>         int minor_base = class_driver->minor_base;
>         int minor = 0;
> -       char name[DEVICE_ID_SIZE];
> +       char name[BUS_ID_SIZE];
>         struct class_device *class_dev;
>         char *temp;
>  

In your case, BUS_ID_SIZE doesn't look appropriate here either, because
the name is never used directly as a bus_id. You should probably use
your own constant here.

	Arnd <><
