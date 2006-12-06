Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937029AbWLFSQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937029AbWLFSQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936981AbWLFSQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:16:30 -0500
Received: from [212.33.185.119] ([212.33.185.119]:32911 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S937029AbWLFSQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:16:30 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: typo in init/initramfs.c
Date: Wed, 6 Dec 2006 21:17:27 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200612062117.27946.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Paul Saman wrote:
>
> In populate_rootfs() the printk on line 554. It says "Unpacking
> initramfs..", which is confusing because if that line is reached the code
> has already decided that the image is an initrd image.

Are you sure?

> The printk is thus
> wrong in stating that it is unpacking an "initramfs". It should says
> "initrd" instead. The attached patch corrects this typo.
>
> Signed-off-by: Jean-Paul Saman <jean-paul.saman@nxp.com>
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index d28c109..f6020db 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -551,7 +551,7 @@ #ifdef CONFIG_BLK_DEV_RAM

This is where initramfs is discerned from initrd, as both are available.

>                         free_initrd();
>                 }
>  #else

Otherwise it's initramfs only.

> -               printk(KERN_INFO "Unpacking initramfs...");
> +              printk(KERN_INFO "Unpacking initrd...");
>                 err = unpack_to_rootfs((char *)initrd_start,
>                         initrd_end - initrd_start, 0);
>                 if (err)
>
> -


Thanks!

--
Al

