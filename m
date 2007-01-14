Return-Path: <linux-kernel-owner+w=401wt.eu-S1751050AbXANDSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbXANDSW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 22:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXANDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 22:18:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39555 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbXANDSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 22:18:21 -0500
Message-ID: <45A9A0F2.4090608@garzik.org>
Date: Sat, 13 Jan 2007 22:18:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Faik Uygur <faik@pardus.org.tr>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: ahci_softreset prevents acpi_power_off
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no> <fa.1s/e9SHVR6LQC2HgdZRykrqlV5Q@ifi.uio.no> <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no> <45A9860D.5080506@shaw.ca>
In-Reply-To: <45A9860D.5080506@shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Faik Uygur wrote:
>>> What happens when you try to shutdown?  
>>
>> Does not shutdown and freezes.
>>
>> Hand copied last messages seen on console:
>>
>> Synchronizing SCSI cache for disk sda:
>> ACPI: PCI Interrupt for device 0000:06:08.0 disabled
>> Power down.
>> acpi_power_off called
>>   hwsleep-0285 [01] enter_sleep_state    : Entering sleep state [S5]
> 
> Since you're getting to this point I think this has to be some kind of 
> BIOS interaction causing this. The only thing that happens after the 
> "Entering sleep state" is that the kernel writes to some ACPI registers 
> to tell the hardware to power down. I think some laptop BIOSes do things 
> on ACPI power down like try to park the drive heads, etc. and maybe this 
> change that you found from git bisecting is somehow interfering with it 
> doing this?
> 
> Might want to check for a BIOS update first of all..

It would be interesting to try -mm, which includes ACPI support for ATA...

	Jeff



