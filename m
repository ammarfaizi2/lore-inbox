Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTFDW0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTFDW0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:26:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264242AbTFDW0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:26:13 -0400
Message-ID: <3EDE7522.8040206@pobox.com>
Date: Wed, 04 Jun 2003 18:39:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI cache line messages 2.4/2.5
References: <5.1.0.14.2.20030602084908.00aed558@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20030602084908.00aed558@pop.t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margit Schubert-While wrote:
> Getting this with 2.5.70(-bk)  :
> PCI: cache line size of 128 is not supported by device 00:1d.7
> 
> and this with 2.4.2(0,1,pre,rc) :
> PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
> PCI: 00:1d.7 PCI cache line size corrected to 128.
> 
> This is the onboard USB EHCI (Intel D845 PESV).
> lspci below.
> 
> What's going on ?


Pretty much exactly what the message says :)

Your BIOS did not set the PCI cache line size correctly.  The kernel 
caught that mistake, and fixed it.

	Jeff



