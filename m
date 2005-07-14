Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVGNIEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVGNIEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 04:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVGNIEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 04:04:30 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:30226 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262953AbVGNIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 04:04:29 -0400
To: jengelh@linux01.gwdg.de
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.61.0507132213450.23970@yvahk01.tjqt.qr> (message from
	Jan Engelhardt on Wed, 13 Jul 2005 22:17:39 +0200 (MEST))
Subject: Re: [PATCH] Fuse chardevice number
References: <Pine.LNX.4.61.0507132213450.23970@yvahk01.tjqt.qr>
Message-Id: <E1Dsyhe-0005A9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Jul 2005 10:04:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  /** The major number of the fuse character device */
> -#define FUSE_MAJOR 10
> +#define FUSE_MAJOR MISC_MAJOR

OK, this makes some sense.

>  /** The minor number of the fuse character device */
> -#define FUSE_MINOR 229
> +#define FUSE_MINOR MISC_DYNAMIC_MINOR

Why?

FUSE has an allocated fix minor.  Dynamic minor is much harder to
handle with legacy /dev (not udev).

Thanks,
Miklos
