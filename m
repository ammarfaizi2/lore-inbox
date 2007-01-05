Return-Path: <linux-kernel-owner+w=401wt.eu-S1161104AbXAEOKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbXAEOKA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbXAEOJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:09:59 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3399 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161104AbXAEOJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:09:59 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH UPDATED 2.6.20-rc3] Remove all the unneeded k[mzc]alloc casts
Date: Fri, 5 Jan 2007 15:10:02 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070105102623.GB382@Ahmed>
In-Reply-To: <20070105102623.GB382@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051510.03206.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> @@ -1932,16 +1932,16 @@ static int init_dev(struct tty_driver *driver, int idx,

[...]

> -		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
> -						GFP_KERNEL);
> +		tp = kmalloc(sizeof(struct ktermios),
> +			     GFP_KERNEL);

[...]

> -		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
> -						 GFP_KERNEL);
> +		ltp = kmalloc(sizeof(struct ktermios),
> +			      GFP_KERNEL);

Don't want to be pain in the ass but these (and a few more) will fit in one line just fine.

-- 
Regards,

	Mariusz Kozlowski
