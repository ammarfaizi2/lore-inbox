Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTK3TIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTK3TIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:08:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262940AbTK3TIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:08:39 -0500
Message-ID: <3FCA4028.7050201@pobox.com>
Date: Sun, 30 Nov 2003 14:08:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [PATCH][2.6] e100_phy.c uses free'd .text after init
References: <Pine.LNX.4.58.0311290033120.1674@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311290033120.1674@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> diff -u -p -B -r1.1.1.1 e100_phy.c
> --- linux-2.6.0-test11/drivers/net/e100/e100_phy.c	28 Nov 2003 18:03:05 -0000	1.1.1.1
> +++ linux-2.6.0-test11/drivers/net/e100/e100_phy.c	29 Nov 2003 05:39:53 -0000
> @@ -132,7 +132,7 @@ e100_mdi_read(struct e100_private *bdp,
>  	}
>  }
> 
> -static unsigned char __devinit
> +static unsigned char
>  e100_phy_valid(struct e100_private *bdp, unsigned int phy_address)
>  {
>  	u16 ctrl_reg, stat_reg;
> @@ -150,7 +150,7 @@ e100_phy_valid(struct e100_private *bdp,
>  	return true;
>  }
> 
> -static void __devinit
> +static void
>  e100_phy_address_detect(struct e100_private *bdp)
>  {
>  	unsigned int addr;


I should probably move that patch from net-drivers-2.5-exp to mainline, 
it sounds like...

	Jeff



