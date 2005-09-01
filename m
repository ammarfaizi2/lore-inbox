Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVIAUsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVIAUsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVIAUsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:48:33 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:31057 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030379AbVIAUsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:48:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=l7EnFtsDcTsbXwO8NkZ03XFT/gcnPsRUHcyOXGPb9cz1GtRD4Srf5tsqUVOefH6xi0k2LUWabD8RGy0kA9sVnoCiEfxUy1731JMpEi6YyhHRcAOzYHfaqhnkuEj9XtaCs2aSL6VID+AczVJA/nRgeRu/0Bo1nabXHmYRUD5V9ww=
Message-ID: <4317777D.7020301@gmail.com>
Date: Fri, 02 Sep 2005 00:49:49 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to
 KERN_INFO
References: <43177223.8030403@gmail.com> <431766C2.2020604@gmail.com>
In-Reply-To: <431766C2.2020604@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Jiri Slaby wrote:

> Alon Bar-Lev napsal(a):
>
>> Hello,
>>
>>
>> When upgrading to 2.6.13 I've noticed that serial driver reports it 
>> status with unknown severity, causing the boot-splash to be overridden.
>>
>>
>> Please consider this modification.
>>
>>
>> Best Regards,
>>
>> Alon Bar-Lev.
>>
>>
>> At drivers/serial/serial_core.c
>>
>>
>> static inline void
>>
>> uart_report_port(struct uart_driver *drv, struct uart_port *port)
>> {
>> -        printk("%s%d", drv->dev_name, port->line);
>> +      printk(KERN_INFO + "%s%d", drv->dev_name, port->line);
>
>
> plus sign between that?

You are right!!! the + is mistake.
The KERN_INFO is the main fix.

>
>>
>>         printk(" at ");
>
>
> why the fellows didn't put this to the line above?

Regarding the other comments... I really don't know... this is how the 
driver is written....
I would have constructed a string and only then printk it...

Regards,
Alon Bar-Lev.

