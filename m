Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283768AbRK3THv>; Fri, 30 Nov 2001 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283767AbRK3THm>; Fri, 30 Nov 2001 14:07:42 -0500
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:47897 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283760AbRK3THa>; Fri, 30 Nov 2001 14:07:30 -0500
Message-ID: <3C07D8EA.988130B1@mandrakesoft.com>
Date: Fri, 30 Nov 2001 14:07:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too.c
In-Reply-To: <200111301123.UAA23808@asami.proc.flab.fujitsu.co.jp> <20011130095717.F15936@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Please try to keep patches relative to the linux/ directory, so they can
> be applied via "patch -p1" as most other kernel patches are.  Also note
> that you should CC the driver maintainer if you want to get the patch
> into the kernel (in this case Jeff Garzik <jgarzik@mandrakesoft.com>).

Kumon forgot... he resent privately

> --- linux/drivers/net/8139too.c.orig    Sun Nov 25 10:46:36 2001
> +++ linux/drivers/net/8139too.c Fri Nov 30 19:50:48 2001

patch applied

> -                  tp->tx_flag | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
> +                  tp->tx_flag | max(len, (unsigned int)ETH_ZLEN));

style:  use max_t if you need to cast.  I'll fix it up.

thanks to you both,

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

