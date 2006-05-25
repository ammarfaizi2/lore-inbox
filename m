Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWEYKf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWEYKf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWEYKf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:35:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61343 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965113AbWEYKf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:35:58 -0400
Message-ID: <4475888B.60405@garzik.org>
Date: Thu, 25 May 2006 06:35:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com> <44758683.4070205@garzik.org> <4475879B.6030003@gmail.com>
In-Reply-To: <4475879B.6030003@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Jeff Garzik napsal(a):
>> Jiri Slaby wrote:
>>>>> +unprobe:
>>>>> +    for (j = i; j > 0; j--) {
>>>>> +        struct gt96100_if_t *gtif = &gtifs[j - 1];
>>>>> +        gt96100_remove1(gtif);
>>>>> +    }
>>>>> +    kfree(gtifs);
>>>> upon failure, you fail to set drvdata back to NULL
>>> What is the purpose of setting this to NULL, other drivers don't do
>>> that too?
>> A simple grep(1) shows well over 300 cases that do this.
> But also shows the latter case: some of them do not have pci_dev_setdrv([^,]*,
> NULL) -- it finds only one occurence of that function (that set the value).

There are hundreds of occurrences of pci_set_drvdata(dev, NULL), and 
many more for non-PCI functions such as dev_set_drvdata() that do the same.

	Jeff



