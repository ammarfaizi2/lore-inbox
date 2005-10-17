Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVJQPxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVJQPxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVJQPxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:53:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52144 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751405AbVJQPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:53:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4353CA12.8020708@s5r6.in-berlin.de>
Date: Mon, 17 Oct 2005 17:58:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: rob <rob@janerob.com>, Andrew Morton <akpm@osdl.org>,
       jbarnes@virtuousgeek.org, Jody McIntyre <scjody@modernduck.com>
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <20051017005515.755decb6.akpm@osdl.org> <4353705D.6060809@s5r6.in-berlin.de> <20051017024219.08662190.akpm@osdl.org> <20051017124711.M44026@janerob.com>
In-Reply-To: <20051017124711.M44026@janerob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.783) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rob wrote:
> On Mon, 17 Oct 2005 02:42:19 -0700, Andrew Morton wrote
>>Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>>>Earlier forms of the patch do DMI matching:
>>>http://marc.theaimsgroup.com/?l=linux1394-devel&m=110790513206094
>>>http://www.janerob.com/rob/ts5100/tosh-1394.patch
>>>[short-circuited by if (1) at the second URL]
>>
>>Rob, can you finish that patch off and send it?
> 
> Sorry, I was advised that this should be correctly handled as a pci-quirk
> (Jody McIntyre <scjody@modernduck.com>),

Since Jesse found that we really need to read & write back the 
PCI_CACHE_LINE_SIZE, I gather the workaround has to stay in ohci1394 
(and should be triggered by dmi_check_system), doesn't it?

> and subsequently my laptop
> motherboard died so I have no way of taking it further.

We should be able to finish it.

> The responses I got
> indicated that the code works as is for the followiung laptops
> 
>>System Vendor: TOSHIBA
>>Product Name: S5100-501
>>Version: PS510E-00NV7-EN
> 
> System Vendor: TOSHIBA
> Product Name: S5200-801
> Version: PS520E-31P1D-GR
> 
> Manufacturer: TOSHIBA
> Product Name: Satellite 5200
> Version: PS520C-31P0EP
> 
> Manufacturer: TOSHIBA
> Product Name: Satellite 5205
> Version: PS522U-XK00YV
> 
> Manufacturer: TOSHIBA
> Product Name: S5100-603
> Version: PS511E-05328-GR
> 
> toshiba satellite 5005-S504
> 
> Toshiba Satellite 5105-s607

Thanks a lot for the survey. Do they all _need_ the patch, or do some of 
them need it and the others are just not harmed by the patch?

Does anybody know a DMI_PRODUCT_NAME of a Libretto L1? Something like 
PAL1060TNMM or PAL1060TNCM?
-- 
Stefan Richter
-=====-=-=-= =-=- =---=
http://arcgraph.de/sr/


