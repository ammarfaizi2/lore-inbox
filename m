Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWGBSNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWGBSNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGBSNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:13:08 -0400
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:45743
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S964856AbWGBSNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:13:07 -0400
Message-ID: <44A80CB1.6060107@seclark.us>
Date: Sun, 02 Jul 2006 14:13:05 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: isa_memcpy_fromio
References: <44A732E3.10202@seclark.us>	 <1151834671.14346.5.camel@localhost.localdomain>	 <20060702090713.bd3a2e68.rdunlap@xenotime.net>	 <44A7FBBE.9070809@seclark.us> <1151861865.3111.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1151861865.3111.23.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Would someone recommend how this should be changed?
>>
>>    
>>
>
>Hi,
>
>the kernel already has a full DMI decoder, this module appears to just
>try to duplicate it (at least judging on the snippet you pasted). It'd
>be a lot better if the module would just use the existing DMI layer...
>If it did that then it doesn't need isa_memcpy_fromio() *at all*...
>
>see the drivers/firmware/dmi_scan.c file for the linux DMI layer code.
>
>Greetings,
>   Arjan van de Ven
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi,

Your right - I didn't even look at the beginning of the module - since I 
was just compiling
it after upgrading to 2.6.17-1.2139_FC5.

 From the beginning of the file:
/*
 * dmi.c -- to get DMI information
 *
 * This code originally came from file arch/i386/kernel/dmi_scan.c from
 * Linux kernel version 2.4.18
 *

Thanks,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



