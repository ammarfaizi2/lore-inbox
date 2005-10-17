Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVJQLUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVJQLUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJQLUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:20:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59531 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751062AbVJQLUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:20:23 -0400
Message-ID: <435388F1.3050101@pobox.com>
Date: Mon, 17 Oct 2005 07:20:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata: fix broken Kconfig setup
References: <20051017044606.GA1266@havoc.gtf.org> <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
In-Reply-To: <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:

Please use the standard 'group reply' feature of your mailer, to ensure 
that me and other people in the thread are CC'd.


> Hi, Jeff Garzik wrote:
> 
> 
>> config SCSI_SATA
>>-	tristate "Serial ATA (SATA) support"
>>+	bool "Serial ATA (SATA) support"
>>	depends on SCSI
> 
> 
> In other words, if SCSI is false then SCSI_SATA is false too.
> 
> So why are you doing
> 
> 
>>+if SCSI_SATA
>>+
>> config SCSI_SATA_AHCI
>> 	tristate "AHCI SATA support"
>>-	depends on SCSI_SATA && PCI
>>+	depends on SCSI && PCI
> 
> 
> and not just
>   +     depends on PCI
> 
> ?

Because if SCSI==m, then a low-level driver cannot be ==y.

	Jeff


