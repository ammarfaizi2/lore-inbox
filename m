Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSG3OBK>; Tue, 30 Jul 2002 10:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSG3OBK>; Tue, 30 Jul 2002 10:01:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318272AbSG3OBJ>;
	Tue, 30 Jul 2002 10:01:09 -0400
Message-ID: <3D469CEF.1040104@mandrakesoft.com>
Date: Tue, 30 Jul 2002 10:04:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro 0.13a
References: <20020730125601.GT16077@cathedrallabs.org.suse.lists.linux.kernel> <p73sn21s5ij.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>@@ -633,37 +633,37 @@
>> 
>> 	i = inb(dev->base_addr + ID_REG);
>> 	printk(KERN_DEBUG " id: %#x ",i);
>>-	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
>>+	printk(" io: %#x ", (unsigned)dev->base_addr);
>> 
>> 	switch (lp->eepro) {
>> 		case LAN595FX_10ISA:
>>-			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
>>+			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
>> 					dev->name, (unsigned)dev->base_addr);
> 
> 
> [more cases deleted]
> 
> This surely can't be right. Why are you dropping all the KERN_*s ?


I have a feeling he ran a diff between his "pure" copy and the kernel 
copy, and assumed the output was correct....

	Jeff




