Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUI3SK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUI3SK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUI3SK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:10:29 -0400
Received: from mail3.praxissolutions.com ([141.149.200.3]:5129 "EHLO
	odysseynetworks.net") by vger.kernel.org with ESMTP id S269372AbUI3SK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:10:27 -0400
Message-ID: <415C4BD8.40005@acipower.com>
Date: Thu, 30 Sep 2004 14:09:28 -0400
From: "Andrey S. Klochko" <aklochko@acipower.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Franz Pletz <franz_pletz@t-online.de>, Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info> <415C37D8.20203@t-online.de> <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: sendmail@acipower.com
X-MDRemoteIP: 129.44.218.101
X-Return-Path: aklochko@acipower.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Spam-Processed: odysseynetworks.net, Thu, 30 Sep 2004 14:14:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> 
>   * One readl should be good to PCI @ 100MHz
>   */
> -#define mii_delay(dev)  readl(dev->base_addr + EECtrl)
> +#define mii_delay(dev)  readl(ioaddr + EECtrl)
                      ^^^
Probably this should be
+#define mii_delay(ioaddr)  readl(ioaddr + EECtrl)

and than change all occurrences of
mii_delay(dev) to mii_delay(ioaddr)
?
>  static int mii_getbit (struct net_device *dev)
>  {

Thanks,

Andrey

-----------
Andrey Klochko
System Administrator
Applied Concepts, Inc.

