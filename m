Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbULIROh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbULIROh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULIROg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:14:36 -0500
Received: from nefty.hu ([195.70.37.175]:10194 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S261570AbULIROE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:14:04 -0500
Message-ID: <41B887D4.8040609@nefty.hu>
Date: Thu, 09 Dec 2004 18:13:56 +0100
From: Zoltan NAGY <nagyz@nefty.hu>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-bk4 does not compile
References: <41B87A67.30803@nefty.hu> <41B877E6.1050007@osdl.org>
In-Reply-To: <41B877E6.1050007@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Zoltan NAGY wrote:
>
>> It fails with the following error messages:
>>
>>  CC      drivers/block/rd.o
>> drivers/block/rd.c:67: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
>> here (not in a function)
>> drivers/block/rd.c:68: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
>> here (not in a function)
>> drivers/block/rd.c:69: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
>> here (not in a function)
>> drivers/block/rd.c: In function `rd_cleanup':
>> drivers/block/rd.c:403: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
>> (first use in this function)
>> drivers/block/rd.c:403: error: (Each undeclared identifier is 
>> reported only once
>> drivers/block/rd.c:403: error: for each function it appears in.)
>> drivers/block/rd.c: In function `rd_init':
>> drivers/block/rd.c:433: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
>> (first use in this function)
>> drivers/block/rd.c: At top level:
>> drivers/block/rd.c:67: error: storage size of `rd_disks' isn't known
>> drivers/block/rd.c:68: error: storage size of `rd_bdev' isn't known
>> drivers/block/rd.c:69: error: storage size of `rd_queue' isn't known
>> drivers/block/rd.c:67: warning: `rd_disks' defined but not used
>> drivers/block/rd.c:68: warning: `rd_bdev' defined but not used
>> drivers/block/rd.c:69: warning: `rd_queue' defined but not used
>> make[2]: *** [drivers/block/rd.o] Error 1
>> make[1]: *** [drivers/block] Error 2
>> make: *** [drivers] Error 2
>
>
> That's weird.  rd.c #includes <config.h>, so CONFIG_BLK_DEV_RAM_COUNT
> should be there.  and it builds OK for me, as module or in-kernel.
>
> Please check that you have rc3-bk4 applied (patched) correctly
> and then send your .config file.
>
Ok, found it. I've tried to build that kernel for UML, and UML's 
defconfig does not contain CONFIG_BLK_DEV_RAM_COUNT...
Gerd Knorr posted a patch[1], and it should really go into 2.6.10, or 
UML wont build.

[1]: http://www.uwsg.iu.edu/hypermail/linux/kernel/0412.0/1429.html

Regards,

Zoltan NAGY,
Software Engineer


