Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUFHGOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUFHGOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbUFHGOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:14:33 -0400
Received: from may.priocom.com ([213.156.65.50]:14244 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264858AbUFHGOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:14:30 -0400
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
	drivers/pci/hotplug/shpchprm_acpi.c
From: Yury Umanets <torque@ukrpost.net>
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dely.l.sy@intel.com
In-Reply-To: <20040607173552.GC2413@tirion.prodam>
References: <1086538851.2793.90.camel@firefly>
	 <20040606105106.01c2fec9.rddunlap@osdl.org>
	 <20040607173552.GC2413@tirion.prodam>
Content-Type: text/plain
Message-Id: <1086675280.2818.4.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 09:14:40 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 20:35, Luiz Fernando N. Capitulino wrote:
>  Hello Randy, Yury,
> 
> Em Sun, Jun 06, 2004 at 10:51:06AM -0700, Randy.Dunlap escreveu:
> 
> | On Sun, 06 Jun 2004 19:20:51 +0300 Yury Umanets wrote:
> | 
> | | Adds memory allocation checks in acpi_get__hpp()
> | | 
> | |  ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2 ++
> | |  1 files changed, 2 insertions(+)
> | | 
> | | Signed-off-by: Yury Umanets <torque@ukrpost.net>
> | | 
> | | diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
> | | ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
> | | --- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
> | | 05:32:28 2004
> | | +++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Wed Jun 
> | | 2 14:28:07 2004
> | | @@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
> | |  	}
> | |  
> | |  	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
> | | +	if (!ab->_hpp)
> | | +		goto free_and_return;
> | |  	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
> | |  
> | |  	ab->_hpp->cache_line_size	= nui[0];
> | | 
> | | -- 
> | 
> | All other failure paths in this function use err() to inform the
> | console about what's happening...  so flip a coin, I guess:
> | add a message or say that ACPI already has too many messages.  :(
> 
>  I sent the same patch for this some weeks ago. Dely accepted, but it was
> not applyed. Don't know why.
Hello,

I'm not sure that I know the order of patches reviewing/applying, but it
seems to be depend on contact person busyness and importance of the
patch. This patch is not so important though :)

-- 
umka

