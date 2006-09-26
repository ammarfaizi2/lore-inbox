Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWIZH7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIZH7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWIZH7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:59:11 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:64679 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750772AbWIZH7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:59:09 -0400
Subject: Re: [PATCH] nomzomi: remove bogus cast
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1159223925.11049.160.camel@localhost.localdomain>
References: <1159223925.11049.160.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:59:32 +0200
Message-Id: <1159257572.1235.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> May as well go straight into the main tree
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/char/nozomi.c linux-2.6.18-mm1/drivers/char/nozomi.c
> --- linux.vanilla-2.6.18-mm1/drivers/char/nozomi.c	2006-09-25 12:10:08.000000000 +0100
> +++ linux-2.6.18-mm1/drivers/char/nozomi.c	2006-09-25 12:17:53.000000000 +0100
> @@ -1225,7 +1225,7 @@
>      }
>  
>      if ( !(dc = get_dc_by_pdev(dev_id)) )  {
> -        ERR("Could not find device context from pci_dev: %d", (u32) dev_id);
> +        ERR("Could not find device context from pci_dev: %p", dev_id);
>          return IRQ_NONE;
>      }
>  

this driver needs more love than this ;)

Regards

Marcel


