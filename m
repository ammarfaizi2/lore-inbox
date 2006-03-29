Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWC2OgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWC2OgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWC2OgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:36:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57304 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750761AbWC2OgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:36:14 -0500
Message-ID: <442A9B5A.5020703@garzik.org>
Date: Wed, 29 Mar 2006 09:36:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       James Cloos <cloos@jhcloos.com>
Subject: Re: Schedule for adding pata to kernel?
References: <5SuEq-6ut-39@gated-at.bofh.it> <5TDme-22E-27@gated-at.bofh.it> <5UAcC-3bd-3@gated-at.bofh.it> <5UH4o-4RJ-27@gated-at.bofh.it> <5UTfA-5uK-17@gated-at.bofh.it> <442A9A1C.1020004@shaw.ca>
In-Reply-To: <442A9A1C.1020004@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> James Cloos wrote:
>> Incidently, on that front, what is the magic to make it work?
>>
>> I've not yet tried with 2.6.16 final, but I didn't have any luck with
>> earlier versions.
>>
>> I have a:
>>
>> ,----[lspci]
>> | 00:1f.1 0101: 8086:244a (rev 03)
>> | 00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
>> `----
>>
>> but never managed to determine the CONFIG that used ata_piix rather
>> than the old ide drivers.  Each attempt left me with a kernel which
>> could not mount its root....
> 
> What distribution? If you're building ata_piix and the other drivers 
> (scsi, sd, etc.) as modules you'll have to play with your initrd to get 
> it to load the correct modules on startup. If you build them into the 
> kernel, it should just work..

Normally you add the requisite drivers to /etc/modprobe.conf, and 
mkinitrd should select the correct modules from there.

	Jeff



