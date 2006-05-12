Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWELJ0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWELJ0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWELJ0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:26:50 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:2553 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1751102AbWELJ0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:26:49 -0400
Message-ID: <446454ED.9060304@maintech.de>
Date: Fri, 12 May 2006 11:27:09 +0200
From: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060508)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Vrabel <dvrabel@cantab.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Iain Barker <ibarker@aastra.com>
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards
 if IO space is not available (2nd revision)
References: <44629D10.80803@maintech.de> <1147362779.26130.45.camel@localhost.localdomain> <44643B80.5080109@maintech.de> <446452F5.10909@cantab.net>
In-Reply-To: <446452F5.10909@cantab.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Vrabel wrote:

>Thomas Kleffel (maintech GmbH) wrote:
>  
>
>>+void outb_io(unsigned char value, unsigned long port) {
>>+	outb(value, port);
>>+}
>>+
>>+void outb_mem(unsigned char value, unsigned long port) {
>>+	writeb(value, (void __iomem *) port);
>> }
>>    
>>
>
>[...]
>
>  
>
>>+    if(is_mmio) 
>>+    	my_outb = outb_mem;
>>+    else
>>+    	my_outb = outb_io;
>>    
>>
>
>
>Shouldn't you convert ide_cs to use iowrite8 (and friends) instead of
>doing this?
>  
>
You're right. I didn't know about iowrite8.

I'll post a new revision soon.

Thomas
