Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTFMOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFMOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 10:07:57 -0400
Received: from vopmail.neto.com ([209.223.15.78]:45330 "EHLO vopmail.neto.com")
	by vger.kernel.org with ESMTP id S265401AbTFMOHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 10:07:54 -0400
Message-ID: <3EE9DED5.5060907@neto.com>
Date: Fri, 13 Jun 2003 09:25:25 -0500
From: John T Copeland <johnc@neto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linuxkernel <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver
References: <Pine.LNX.4.10.10306121618270.806-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10306121618270.806-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>Until the device ordering can be sorted out, your pain will be the
>following:
>
>ide0=0x1f0,0x3f6,14 ide1=0x170,0x376,15
>
>Cheers,
>
>Andre Hedrick
>LAD Storage Consulting Group
>
>On Thu, 12 Jun 2003, John T Copeland wrote:
>
>  
>
>>Alan,
>>A couple of questions if you please.
>>
>>1)  When I compile the siimage driver into the kernel, the ide buses are 
>>scanned in the following order:
>>  IDE0 - SATA primary - hda, hdb
>>  IDE1 - SATA secondary - hdc, hdd
>>  IDE2 - ATA tertiary - hde, hdf
>>  IDE3 - ATA quandrary hdg, hdh
>>I want the ATA to be IDE0/1  and SATA to be IDE2/3.  I have noticed from 
>>some of the posts about the siimage driver on the ASUS nforce2 mobo this 
>>is the apparent order scanned.  My mobo is an Abit NF7-S nforce2.  Is 
>>there someway of controlling the order of scannin the IDE buses?  I 
>>tried append="ide=reverse" to no avail.
>>
>>2) To try and get the nforce2 IDE buses scanned first, I compiled 
>>siimage as a module, but when I did an "insmod siimage" I get an 
>>unresolved external, "noautodma", in siimage.
>>
>>I'd appreciate any help you can offer.
>>
>>Thanks,
>>John Copeland
>> 
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>  
>
Thanks Andre, that gets the job done.
JohnC

