Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVCKQjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVCKQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVCKQjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:39:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31714 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261194AbVCKQjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:39:17 -0500
Message-ID: <4231C9B2.5020202@us.ltcfwd.linux.ibm.com>
Date: Fri, 11 Mar 2005 11:39:14 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Wen Xiong <wendyx@us.ibm.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ patch 3/5] drivers/serial/jsm: new serial device driver
References: <20050228063954.GB23595@kroah.com>	 <4228CE41.2000102@us.ltcfwd.linux.ibm.com>	 <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com>	 <20050308064424.GF17022@kroah.com>	 <422DF525.8030606@us.ltcfwd.linux.ibm.com>	 <20050308235807.GA11807@kroah.com>	 <422F1A8A.4000106@us.ltcfwd.linux.ibm.com>	 <20050309163518.GC25079@kroah.com>	 <422F2FDD.4050908@us.ltcfwd.linux.ibm.com>	 <20050309185800.GA27268@kroah.com>	 <4231BB5D.8020400@us.ltcfwd.linux.ibm.com> <1110556428.9917.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1110556428.9917.31.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Fri, 2005-03-11 at 10:38 -0500, Wen Xiong wrote:
>
>  
>
>>+static void neo_set_cts_flow_control(struct jsm_channel *ch)
>>+{
>>+	u8 ier = readb(&ch->ch_neo_uart->ier);
>>+	u8 efr = readb(&ch->ch_neo_uart->efr);
>>+
>>    
>>
>...
>  
>
>>+
>>+	writeb(ier, &ch->ch_neo_uart->ier);
>>+}
>>    
>>
>
>
>Hi,
>
>have you ever audited this driver for PCI posting errors? On very first
>sight it looks like the driver doesn't do this correctly but it might
>just be very subtle...
>
>
>  
>
Jeff pointed out several PCI posting errors last time.  Before we used 
udelay and now we changed to readb/readl instead of udelay this time.
But we only used PCI posting when we think maybe delay there.
So we have to do PCI posting on every writeb? Do you have some rules for 
doing PCI posting while writeb? depends on what kind of registers?

Thanks,
wendy

