Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUFGRvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUFGRvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbUFGRvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:51:46 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:25095 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264959AbUFGRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:51:29 -0400
Date: Mon, 7 Jun 2004 14:35:52 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Yury Umanets <torque@ukrpost.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dely.l.sy@intel.com
Subject: Re: [PATCH] 2.6.6 memory allocation checks in drivers/pci/hotplug/shpchprm_acpi.c
Message-ID: <20040607173552.GC2413@tirion.prodam>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Yury Umanets <torque@ukrpost.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, dely.l.sy@intel.com
References: <1086538851.2793.90.camel@firefly> <20040606105106.01c2fec9.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606105106.01c2fec9.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello Randy, Yury,

Em Sun, Jun 06, 2004 at 10:51:06AM -0700, Randy.Dunlap escreveu:

| On Sun, 06 Jun 2004 19:20:51 +0300 Yury Umanets wrote:
| 
| | Adds memory allocation checks in acpi_get__hpp()
| | 
| |  ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2 ++
| |  1 files changed, 2 insertions(+)
| | 
| | Signed-off-by: Yury Umanets <torque@ukrpost.net>
| | 
| | diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
| | ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
| | --- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May 10
| | 05:32:28 2004
| | +++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c	Wed Jun 
| | 2 14:28:07 2004
| | @@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
| |  	}
| |  
| |  	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
| | +	if (!ab->_hpp)
| | +		goto free_and_return;
| |  	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
| |  
| |  	ab->_hpp->cache_line_size	= nui[0];
| | 
| | -- 
| 
| All other failure paths in this function use err() to inform the
| console about what's happening...  so flip a coin, I guess:
| add a message or say that ACPI already has too many messages.  :(

 I sent the same patch for this some weeks ago. Dely accepted, but it was
not applyed. Don't know why.


-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
