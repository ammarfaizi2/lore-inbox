Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULIQzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULIQzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULIQzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:55:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:20203 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbULIQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:54:25 -0500
Message-ID: <41B877E6.1050007@osdl.org>
Date: Thu, 09 Dec 2004 08:05:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zoltan NAGY <nagyz@nefty.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-bk4 does not compile
References: <41B87A67.30803@nefty.hu>
In-Reply-To: <41B87A67.30803@nefty.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan NAGY wrote:
> It fails with the following error messages:
> 
>  CC      drivers/block/rd.o
> drivers/block/rd.c:67: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared here 
> (not in a function)
> drivers/block/rd.c:68: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared here 
> (not in a function)
> drivers/block/rd.c:69: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared here 
> (not in a function)
> drivers/block/rd.c: In function `rd_cleanup':
> drivers/block/rd.c:403: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
> (first use in this function)
> drivers/block/rd.c:403: error: (Each undeclared identifier is reported 
> only once
> drivers/block/rd.c:403: error: for each function it appears in.)
> drivers/block/rd.c: In function `rd_init':
> drivers/block/rd.c:433: error: `CONFIG_BLK_DEV_RAM_COUNT' undeclared 
> (first use in this function)
> drivers/block/rd.c: At top level:
> drivers/block/rd.c:67: error: storage size of `rd_disks' isn't known
> drivers/block/rd.c:68: error: storage size of `rd_bdev' isn't known
> drivers/block/rd.c:69: error: storage size of `rd_queue' isn't known
> drivers/block/rd.c:67: warning: `rd_disks' defined but not used
> drivers/block/rd.c:68: warning: `rd_bdev' defined but not used
> drivers/block/rd.c:69: warning: `rd_queue' defined but not used
> make[2]: *** [drivers/block/rd.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2

That's weird.  rd.c #includes <config.h>, so CONFIG_BLK_DEV_RAM_COUNT
should be there.  and it builds OK for me, as module or in-kernel.

Please check that you have rc3-bk4 applied (patched) correctly
and then send your .config file.

-- 
~Randy
