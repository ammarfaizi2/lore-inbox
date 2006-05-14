Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWENNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWENNLW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 09:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWENNLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 09:11:22 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:23017 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750955AbWENNLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 09:11:21 -0400
Message-ID: <44672C94.6090408@maintech.de>
Date: Sun, 14 May 2006 15:11:48 +0200
From: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060508)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Iain Barker <ibarker@aastra.com>
CC: David Vrabel <dvrabel@cantab.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards
 if IO space is not available (2nd revision)
References: <ABD6885665C7C74DA65B21A1DB4E4A2FB825D9@bilmail.aastra.com>
In-Reply-To: <ABD6885665C7C74DA65B21A1DB4E4A2FB825D9@bilmail.aastra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>Thomas Kleffel (maintech GmbH) wrote:
>  
>
>>+    if(is_mmio) 
>>+    	my_outb = outb_mem;
>>+    else
>>+    	my_outb = outb_io;
>>    
>>
>
>David Vrabel wrote:
>  
>
>>Shouldn't you convert ide_cs to use iowrite8 (and friends) instead of
>>doing this?
>>    
>>
>
>
>Actually, I think even better to use the primitives from ide-iops.c ?
>  
>
They're declared static in ide-iops.c and I can't get them out of the 
ide_hwif_t struct as it is initialized after I need the primitives.

I think the simplest way is to use my own primitives.

Thomas



