Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWFBV73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFBV73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFBV72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:59:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57559 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750792AbWFBV72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:59:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4480B45E.4060909@s5r6.in-berlin.de>
Date: Fri, 02 Jun 2006 23:57:50 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>, Olaf Hering <olh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: [PATCH 2.6.17-rc5-mm2 17/18] sbp2: provide helptext for	CONFIG_IEEE1394_SBP2_PHYS_DMA
 and mark it experimental
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de> <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de> <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de> <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de> <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de> <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de> <tkrat.f35772c971022262@s5r6.in-berlin.de> <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de> <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de> <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de> <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de> <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de> <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de> <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de> <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de> <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de> <tkrat.96e1b392429fe277@s5r6.in-berlin.de> <tkrat.df90273c07dd7503@s5r6.in-berlin.de> <1149281162.4533.304.camel@grayson>
In-Reply-To: <1149281162.4533.304.camel@grayson>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.733) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> On Fri, 2006-06-02 at 22:27 +0200, Stefan Richter wrote:
>>It appears I will not get it fixed overnight.
> 
>>-	bool "Enable Phys DMA support for SBP2 (Debug)"
>>-	depends on IEEE1394 && IEEE1394_SBP2
>>+	bool "Enable replacement for physical DMA in SBP2"
>>+	depends on IEEE1394 && IEEE1394_SBP2 && EXPERIMENTAL
> 
> 
> Please add '&& !SPARC' to the depends line. Other architectures may
> apply, but I know for sure that this cannot be enabled on SPARC or
> SPARC64 since the module will be unloadable due to missing symbols
> (virt_to_bus, bus_to_virt).

Are there suggestions for more architectures? PPC64?

Or maybe I should put something into sbp2 like
#if defined(CONFIG_X86_32) || defined(CONFIG_PPC32)
	a = bus_to_virt(b);
#else
	printk("this functionality will be brought to you RSN");
#endif
until I had time to implement a proper mapping.
-- 
Stefan Richter
-=====-=-==- -==- ---=-
http://arcgraph.de/sr/
