Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVADN1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVADN1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVADN0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:26:51 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:37040 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S261623AbVADNX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:23:56 -0500
Message-ID: <41DA79EB.20102@telefonica.net>
Date: Tue, 04 Jan 2005 12:11:39 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 resuming laptop from suspension f*cks usb subsystem
References: <41D2C4FA.7010806@telefonica.net> <20050103220704.GB25250@elf.ucw.cz>
In-Reply-To: <20050103220704.GB25250@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>In 2.6.10, resuming from suspend mode just (randomly) crashes the USB 
>>subsystem, and I get the same messages (not sure about the whole message 
>>but the "-84" part really is there) over and over again until I reboot.
>>    
>>
>
>Does it still happen with noapic? 2.6.10 has some interrupt related
>problems with APIC...
>
>								Pavel
>  
>
I have just rebooted 2.6.10 with this LILO command line

    LILO Boot: Linux-2.6.10 noapic

and if that disables APIC, then I've got the same problem. After 
suspending the laptop
two times, I get the same lines (described below) and the usb system 
goes nuts. After
removing & inserting uhci_hcd everything works fine again.

The lines are (endless loop):
drivers/usb/input/hid-core.c: input irq status -84 received

