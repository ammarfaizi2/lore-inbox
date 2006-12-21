Return-Path: <linux-kernel-owner+w=401wt.eu-S1422640AbWLUNKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWLUNKZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWLUNKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:10:25 -0500
Received: from mail.atmel.fr ([81.80.104.162]:39497 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422640AbWLUNKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:10:24 -0500
Message-ID: <458A875D.3000801@rfo.atmel.com>
Date: Thu, 21 Dec 2006 14:08:45 +0100
From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Organization: atmel
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Patrice Vilchez <patrice.vilchez@rfo.atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
References: <4582BD29.4020203@rfo.atmel.com> <200612201513.09705.david-b@pacbell.net>
In-Reply-To: <200612201513.09705.david-b@pacbell.net>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 8bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell a écrit :
> On Friday 15 December 2006 7:20 am, Nicolas FERRE wrote:
>> Add support for the ads7843 touchscreen controller to the ads7846 driver code.
> 
> Glad to see this!  Is this for AT91sam9261-EK board support, maybe?

Indeed ! An also for the AT91sam9263-EK which has the same touchscreen chip.

> Let me try to sort out the mess with those updates, and ask you to refresh
> this ads7843 support against that more-current ads7846 code.

Ok, let me know when you have a newer code. I will try to adapt my
ads7843 support then.

>> As the SPI underlying code behaves quite differently from a controller driver
>> to another whan not having a tx_buf filled, I have add a zerroed buffer to give
>> to the spi layer while receiving data.
> 
> You must be working with a buggy controller driver then.  That part of
> this patch should never be needed.  It's expected that rx-only transfers
> will omit a tx buf; all controller drivers must handle that case.

I said that because it is true that most of spi controller drivers 
manage rx only transactions filling the tx buffer with zerros but the 
spi_s3c24xx.c driver seems to fill with ones (line 177 hw_txbyte())

Anyway, I will check in our controller driver to sort this out.

Regards,
-- 
Nicolas Ferre



