Return-Path: <linux-kernel-owner+w=401wt.eu-S932338AbXAONpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbXAONpG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXAONpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:45:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47500 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338AbXAONpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:45:04 -0500
Message-ID: <45AB8553.10301@garzik.org>
Date: Mon, 15 Jan 2007 08:44:51 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, Faik Uygur <faik@pardus.org.tr>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ahci_softreset prevents acpi_power_off
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no>	 <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no> <45A9860D.5080506@shaw.ca>	 <200701141959.40673.faik@pardus.org.tr> <1168797978.3123.997.camel@laptopd505.fenrus.org> <45AAFCC6.9000700@gmail.com>
In-Reply-To: <45AAFCC6.9000700@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Arjan van de Ven wrote:
>> I'd be interested in finding out how to best test this; if the bios is
>> really broken I'd love to add a test to the Linux-ready Firmware
>> Developer Kit for this, so that BIOS developers can make sure future
>> bioses do not suffer from this bug...
> 
> As reported, this is almost a butterfly effect.  ->softreset method is
> only used during initialization and error recovery of ATA devices which
> has almost nothing to do with the rest of the system.  This is almost
> like 'changing my mixer input to line-in makes power off fail'.  (it's
> more related due to ATA ACPI stuff and maybe that's why this happens but
> I'm trying to make a point here.)

It's quite possible that the BIOS in question wants AHCI in some 
specific state at poweroff.

	Jeff



