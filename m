Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUJ3TLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUJ3TLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUJ3TLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:11:08 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:49886 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261275AbUJ3TKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:10:10 -0400
Message-ID: <4183E711.9030708@verizon.net>
Date: Sat, 30 Oct 2004 15:10:09 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>,
       kernel-janitors@lists.osdl.org
Subject: Re: [KJ] [PATCH] floppy: change MODULE_PARM to module_param in drivers/block/floppy.c
References: <20041030134246.23710.45693.84191@localhost.localdomain> <4183BF5B.5000303@osdl.org> <200410301303.45161.dtor_core@ameritech.net>
In-Reply-To: <200410301303.45161.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Sat, 30 Oct 2004 14:10:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Saturday 30 October 2004 11:20 am, Randy.Dunlap wrote:
> 
>>james4765@verizon.net wrote:
>>
>>>Replace MODULE_PARM with module_param in drivers/block/floppy.c.  Compile tested.
>>>
>>>Signed-off-by: James Nelson <james4765@gmail.com>
>>>
>>>diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
>>>--- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
>>>+++ linux-2.6.9/drivers/block/floppy.c	2004-10-30 09:16:04.856720081 -0400
>>>@@ -180,6 +180,7 @@
>>> #include <linux/devfs_fs_kernel.h>
>>> #include <linux/device.h>
>>> #include <linux/buffer_head.h>	/* for invalidate_buffers() */
>>>+#include <linux/moduleparam.h>
>>> 
>>> /*
>>>  * PS/2 floppies have much slower step rates than regular floppies.
>>>@@ -4623,9 +4624,9 @@
>>> 	wait_for_completion(&device_release);
>>> }
>>> 
>>>-MODULE_PARM(floppy, "s");
>>>-MODULE_PARM(FLOPPY_IRQ, "i");
>>>-MODULE_PARM(FLOPPY_DMA, "i");
>>>+module_param(floppy, charp, 0);
>>>+module_param(FLOPPY_IRQ, int, 0);
>>>+module_param(FLOPPY_DMA, int, 0);
>>> MODULE_AUTHOR("Alain L. Knaff");
>>> MODULE_SUPPORTED_DEVICE("fd");
>>> MODULE_LICENSE("GPL");
>>
>>Please check Andrew's 2.6.10-rc1-mm2 for a large MODULE_PARAM
>>patch, and then convert drivers that are not yet converted...
>>
>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/convert-module_parm-to-module_param-family.patch
>>

Sorry - that was a quickie w/o checking to see if someone else had already done 
it.  See below.

> 
> 
> Actually it would be nice if drivers were converted "intelligently"
> instead of basic find-and-replace - I really find parameter names
> like floppy.floppy= or floppy.floppy_dma= ugly.
> 
Hmm.  I can tak a look at that a little bit later - just got done with a *huge* 
cleanup of floppy.c - just gotta do the diffs and send them.

Jim
