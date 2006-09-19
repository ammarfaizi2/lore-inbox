Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWISKRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWISKRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWISKRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:17:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31108 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751855AbWISKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XIIlx6LmZ2H7HIbJC3HziMv1cFdI6EwvZGmpRAbdujIoH6odyq/ixmnV8unTZzU9pum3FLN8oiDTfbxB9iXfiCWYN3SBvrra3FZ8WkdZ1f22s0KWm/Xh5t40xo1mgawM5i5N53/P0IYtxAo16pobDyur8x+x5EZ+tkoVmmsD9mM=
Message-ID: <450FC3A4.9020402@gmail.com>
Date: Tue, 19 Sep 2006 12:17:08 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Josh Boyer <jdub@us.ibm.com>
CC: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Mark Ferrell <mferrell@mvista.com>
Subject: Re: [PATCH 2/4] pmc551 remove unnecessary braces
References: <91292912129122wcf1@karneval.cz> <1158624979.3600.31.camel@zod.rchland.ibm.com>
In-Reply-To: <1158624979.3600.31.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Boyer wrote:
> On Tue, 2006-09-19 at 00:47 +0200, Jiri Slaby wrote:
>> diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
>> index 6d4d5a4..0ee22ca 100644
>> --- a/drivers/mtd/devices/pmc551.c
>> +++ b/drivers/mtd/devices/pmc551.c
>> @@ -137,11 +137,11 @@ #endif
>>  
>>  	pmc551_point(mtd, instr->addr, instr->len, &retlen, &ptr);
>>  
>> -	if (soff_hi == eoff_hi || mtd->size == priv->asize) {
>> +	if (soff_hi == eoff_hi || mtd->size == priv->asize)
>>  		/* The whole thing fits within one access, so just one shot
>>  		   will do it. */
>>  		memset(ptr, 0xff, instr->len);
>> -	} else {
>> +	else {
>>  		/* We have to do multiple writes to get all the data
>>  		   written. */
>>  		while (soff_hi != eoff_hi) {
> 
> I actually find this change to make the code less readable.  Yes, the
> braces aren't technically necessary, but the else requires them, and the
> comment block before the memset makes this multi-line.
> 
> This whole patch is highly user preference, but I'd rather these braces
> stay.

Yes, I agree. This was one of my old patches stored on other PC, that I find 
now. The patch definitely makes it ugly.

>> @@ -700,9 +695,8 @@ static int __init init_pmc551(void)
>>  
>>  		if ((PCI_Device = pci_find_device(PCI_VENDOR_ID_V3_SEMI,
>>  						  PCI_DEVICE_ID_V3_SEMI_V370PDC,
>> -						  PCI_Device)) == NULL) {
>> +						  PCI_Device)) == NULL)
>>  			break;
>> -		}
> 
> 1) If you're going for coding style, the assignment within the if
> condition needs to be moved outside of it.
> 
> 2) If you're not going to fix 1, then leave the braces.

1) is fine, I will do it, thanks for comments.

-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
