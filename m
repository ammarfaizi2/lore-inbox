Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUCBRlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 12:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUCBRlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 12:41:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33944 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261515AbUCBRlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 12:41:17 -0500
X-Sasl-enc: IJhFrl53D859fb75SQA9jQ 1078248981
Message-ID: <4044C611.5060208@mailcan.com>
Date: Tue, 02 Mar 2004 18:36:17 +0100
From: Leon Woestenberg <leonw@mailcan.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Collins <bcollins@debian.org>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] csr1212 compile fix
References: <Pine.GSO.4.58.0402291708460.7483@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402291708460.7483@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Geert Uytterhoeven wrote:
> 	Hi Ben,
> 
> in_interrupt() needs #include <linux/sched.h> on some platforms (e.g. m68k).
> 
> BTW, shouldn't most of the IEEE1394 stuff depend on CONFIG_PCI? E.g.
> drivers/ieee1394/dma.c uses struct pci_dev and needs pci_alloc_consistent() and
> friends.
> 
> (All found while trying to enable as many drivers as possible)
> 
Although most OHCI implementations are PCI based, there are embedded 
link controllers that are not (OHCI nor) PCI-based.

Here is a driver by Steve Kinneberg that shows how he removed the 
dependencies on CONFIG_PCI and written around the DMA functions.

http://mailman.uclinux.org/pipermail/uclinux-dev/2004-January/023691.html

Based on this driver (thanks again Steve if you read this) we are adding 
support for a Philips link layer device.

Regards,

Leon.

