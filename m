Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVIAVEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVIAVEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVIAVEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:04:44 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:49032 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1030353AbVIAVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:04:44 -0400
Message-ID: <43176CC4.7040105@gmail.com>
Date: Thu, 01 Sep 2005 23:04:04 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Ben Dooks <ben@fluff.org.uk>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to
 KERN_INFO
References: <43177223.8030403@gmail.com> <431766C2.2020604@gmail.com> <20050901204610.GA1816@home.fluff.org>
In-Reply-To: <20050901204610.GA1816@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks napsal(a):

>On Thu, Sep 01, 2005 at 10:38:26PM +0200, Jiri Slaby wrote:
>  
>
>>Alon Bar-Lev napsal(a):
>>    
>>
>>>static inline void
>>>
>>>uart_report_port(struct uart_driver *drv, struct uart_port *port)
>>>{
>>>-        printk("%s%d", drv->dev_name, port->line);
>>>+      printk(KERN_INFO + "%s%d", drv->dev_name, port->line);
>>>      
>>>
>>plus sign between that?
>>
>>    
>>
>>>       printk(" at ");
>>>      
>>>
>>why the fellows didn't put this to the line above?
>>    
>>
>>>       switch (port->iotype) {
>>>       case UPIO_PORT:
>>>               printk("I/O 0x%x", port->iobase);
>>>      
>>>
>>And what about these?
>>    
>>
>
>looks like they're not on a newline, so need no severity.
>  
>
ok, ok, but isn't this a little bit racy (so you can see dev_name and 
line, then another driver's info and then " at ", then something else...)

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

