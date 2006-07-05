Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWGELhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWGELhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGELhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:37:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:408 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964819AbWGELhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:37:46 -0400
Subject: Re: [PATCH] hisax fix usage of __init*
From: Arjan van de Ven <arjan@infradead.org>
To: Karsten Keil <kkeil@suse.de>
Cc: greg@kroah.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060705112357.GA7003@pingi.kke.suse.de>
References: <20060705112357.GA7003@pingi.kke.suse.de>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 13:37:38 +0200
Message-Id: <1152099459.3201.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 13:23 +0200, Karsten Keil wrote:
> diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
> index 5333be5..e103503 100644
> --- a/drivers/isdn/hisax/config.c
> +++ b/drivers/isdn/hisax/config.c
> @@ -1875,7 +1875,7 @@ static void EChannel_proc_rcv(struct his
>  #ifdef CONFIG_PCI
>  #include <linux/pci.h>
>  
> -static struct pci_device_id hisax_pci_tbl[] __initdata = {
> +static struct pci_device_id hisax_pci_tbl[] __devinitdata = {
>  #ifdef CONFIG_HISAX_FRITZPCI
>         {PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,
> PCI_ANY_ID, PCI_ANY_ID},
>  #endif
> diff --git a/drivers

I think this bit is still buggy; afaik pci_device_id tables should not
be of any kind of __init at all... CC'ing Greg just to make sure I'm not
talking rubbish

Greetings,
   Arjan van de Ven

