Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUE3RUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUE3RUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUE3RUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:20:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264205AbUE3RUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:20:46 -0400
Message-ID: <40BA17DF.4040706@pobox.com>
Date: Sun, 30 May 2004 13:20:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Howard <faxguy@howardsilvan.com>
CC: c-d.hailfinger.kernel.2004@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <20040530155715.GA2612@bilbo.x101.com>
In-Reply-To: <20040530155715.GA2612@bilbo.x101.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Howard wrote:
> I use the forcedeth driver for my nVidia ethernet successfully with 
> kernel 2.6.6.  I recently tested 2.6.7-rc1, and when using it the 
> ethernet does not work, and I see this in dmesg:
> 
> eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
> NETDEV WATCHDOG: eth1: transmit timed out
> NETDEV WATCHDOG: eth1: transmit timed out
> NETDEV WATCHDOG: eth1: transmit timed out
> NETDEV WATCHDOG: eth1: transmit timed out
> NETDEV WATCHDOG: eth1: transmit timed out
> 
> I can ping localhost and the device's IP number, but I cannot ping other 
> systems' IP numbers.


Well, there are zero changes to the driver itself, so I would guess ACPI 
perhaps...

Try booting with 'acpi=off' or 'noapic' or 'pci=noacpi' or similar...

	Jeff


