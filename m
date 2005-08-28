Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVH1Rkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVH1Rkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVH1Rkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:40:47 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:62898 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S1750710AbVH1Rkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:40:47 -0400
Message-ID: <4311F72B.2010106@free.fr>
Date: Sun, 28 Aug 2005 19:40:59 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI	resources
 [resend]
References: <200508020955.54844.bjorn.helgaas@hp.com>	 <1123030861.2937.4.camel@linux-hp.sh.intel.com>	 <200508030920.13450.bjorn.helgaas@hp.com>  <42F1343B.70707@free.fr> <1123116712.2929.8.camel@linux-hp.sh.intel.com>
In-Reply-To: <1123116712.2929.8.camel@linux-hp.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Shaohua Li wrote:
> On Wed, 2005-08-03 at 23:16 +0200, matthieu castet wrote:
> 
>>There are drivers/acpi/motherboard.c that done some stuff already handle 
>>by pnp/system.c.
> 
> Yes, it should be disabled if pnpacpi is enabled. 
But even if pnpacpi is disabled, pnp/system.c sould work with pnpbios.
> The only concern is
> motherboard.c also request some ACPI resources, which might not declaim
> in ACPI motherboard device, but it's completely BIOS dependent. We might
> could try remove it at -mm tree to see if it breaks any system later.
> 
> 
Ok,
may be we should split in 2 modules : the one that request some ACPI 
resources and the other that use PNP resource.
>>PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
>>will be removed to register again the pnp device in acpi layer. Do you 
>>plan to add more check and for example add only device that have a CRS 
>>in pnp layer ?
> 
> For detecting PNP device? it's worthy trying.
> 

I will send a patch for that.

Matthieu
