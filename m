Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUI3ULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUI3ULU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269485AbUI3ULT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:11:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269476AbUI3UIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:08:42 -0400
Message-ID: <415C67BA.5040808@pobox.com>
Date: Thu, 30 Sep 2004 16:08:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: torvalds@osdl.org, franz_pletz@t-online.de, michal@rokos.info,
       linux-kernel@vger.kernel.org, akpm@osdl.org, manfred@colorfullife.com
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
References: <200409230958.31758.michal@rokos.info>	<200409231618.56861.michal@rokos.info>	<415C37D8.20203@t-online.de>	<Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>	<415C4EC5.4040603@pobox.com> <20040930125317.5622a909.davem@davemloft.net>
In-Reply-To: <20040930125317.5622a909.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Thu, 30 Sep 2004 14:21:57 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Wouldn't it be better to just phase out the base of dev->base_addr 
>>completely?  I tend to prefer adding a "void __iomem *regs" to struct 
>>netdev_private, and ignore dev->base_addr completely.
> 
> 
> Yes, this is the way to go.
> 
> (BTW, Jeff, technically it's the 'ifmap' that the user uses
>  to pass base_addr into the kernel.  The kernel drivers use
>  the netdev struct one, which is an unsigned long)

Yep, that's why it's truncated to 16-bits in ifconfig output.

	Jeff



