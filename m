Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbVJRUpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbVJRUpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVJRUpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:45:04 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:41377 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751496AbVJRUpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:45:02 -0400
Message-ID: <43555E5E.6010008@dresco.co.uk>
Date: Tue, 18 Oct 2005 21:43:10 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Gyes <floam@sh.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATA warnings in dmesg
References: <1129609999.10504.1.camel@localhost>	 <4354A09C.8010202@dresco.co.uk> <1129642297.12659.3.camel@localhost>
In-Reply-To: <1129642297.12659.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Rutherford-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Gyes wrote:
> On Tue, 2005-10-18 at 08:13 +0100, Jon Escombe wrote:
> 
>>I don't think you need to worry. Those messages are produced from the 
>>libata passthough code, whenever sense data has been requested...
>>
>>0xb0 looks like a SMART command, so I would guess (haven't looked at 
>>-mm) that the ata ioctl handlers have been updated to request it.
> 
> 
> That would make sense. I have a daemon running that requests the
> temperature via SMART every minute or so. Even still, this fills up my
> entire dmesg after not a very long time, can I turn these messages off
> somehow? If not, can you point me to where in the code I could kill a
> printk?
> 
> Aaron Gyes

Sure, the printk is in drivers/scsi/libata-scsi.c, right at the end of 
ata_to_sense_error()..

Regards,
Jon.

______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
