Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161582AbWHDXje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161582AbWHDXje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161583AbWHDXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:39:34 -0400
Received: from mga06.intel.com ([134.134.136.21]:11160 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161582AbWHDXjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:39:33 -0400
X-IronPort-AV: i="4.07,213,1151910000"; 
   d="scan'208"; a="102899022:sNHT25594198511"
Message-ID: <44D3D8F9.2070602@linux.intel.com>
Date: Fri, 04 Aug 2006 16:32:09 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jiri Slaby <slaby@liberouter.org>
CC: liyu <liyu@ccoss.com.cn>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: The HID Simple Driver Interface 0.3.0
References: <200608031806087610533@ccoss.com.cn> <44D3D810.4020903@liberouter.org>
In-Reply-To: <44D3D810.4020903@liberouter.org>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Signed-off-by: Liyu <liyu@ccoss.com.cn>
>>
>> diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/hid-core.c linux-2.6.17.7/drivers/usb/input/hid-core.c
>> --- linux-2.6.17.7/drivers/usb/input.orig/hid-core.c	2006-07-25 11:36:01.000000000 +0800
>> +++ linux-2.6.17.7/drivers/usb/input/hid-core.c	2006-08-03 15:44:45.000000000 +0800
>> @@ -4,6 +4,7 @@
>>   *  Copyright (c) 1999 Andreas Gal
>>   *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
>>   *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
>> + *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  HID simple driver interface
>>   */
>>  
>>  /*
>> @@ -26,6 +27,7 @@
>>  #include <asm/byteorder.h>
>>  #include <linux/input.h>
>>  #include <linux/wait.h>
>> +#include <asm/semaphore.h>
>>  

Hi,

btw I just noticed this, but please use mutexes not semaphores in new code. Sorry for not
noticing this earlier, I'll need to adjust my filters I suspect.

Greetings,
   Arjan van de Ven
