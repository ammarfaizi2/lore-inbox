Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSFMExL>; Thu, 13 Jun 2002 00:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFMExK>; Thu, 13 Jun 2002 00:53:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1803 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314483AbSFMExJ>;
	Thu, 13 Jun 2002 00:53:09 -0400
Message-ID: <3D08246E.6030307@mandrakesoft.com>
Date: Thu, 13 Jun 2002 00:49:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kuebelr@email.uc.edu
CC: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] 3c509.c - 2/2
In-Reply-To: <20020613042736.GB12340@cartman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuebelr@email.uc.edu wrote:
>  static u16 el3_isapnp_phys_addr[8][3];
>  #endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
>  static int nopnp;
> @@ -1265,6 +1261,8 @@
>  MODULE_PARM_DESC(nopnp, "disable ISA PnP support (0-1)");
>  #endif /* CONFIG_ISAPNP */
>  MODULE_DESCRIPTION("3Com Etherlink III (3c509, 3c509B) ISA/PnP ethernet driver");
> +MODULE_DEVICE_TABLE(isapnp, el3_isapnp_adapters);

it doesn't make much sense to have the isapnp device table outside the 
isapnp ifdef.

	Jeff




