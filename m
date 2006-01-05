Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWAEQfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAEQfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWAEQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:35:50 -0500
Received: from ns1.coraid.com ([65.14.39.133]:54757 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750784AbWAEQft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:35:49 -0500
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.15-rc7] aoe [4/7]: use less confusing driver name
References: <87hd8l2fb4.fsf@coraid.com> <871wzp10lm.fsf@coraid.com>
	<2cd57c900601032202y3de62e78m@mail.gmail.com>
	<87mziclztq.fsf@coraid.com>
	<2cd57c900601041650j6b3e7ea6u@mail.gmail.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 05 Jan 2006 11:35:29 -0500
In-Reply-To: <2cd57c900601041650j6b3e7ea6u@mail.gmail.com> (Coywolf Qi
 Hunt's message of "Thu, 5 Jan 2006 08:50:40 +0800")
Message-ID: <87hd8i63am.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> writes:

[Ed writes]
...
>> Coywolf Qi Hunt <coywolf@gmail.com> writes:
...
>> > Better simply be `AoE v%s'?
>>
>> That would be nice, but there's a driver for the 2.4 linux kernel that
>> has an independent version number, so the "6" distinguishes the 2.6
>> aoe driver from the 2.4 aoe driver.
>
> But 2.4 and 2.6 driver never meet each other, right?

Yes, after thinking it over more, I agree.  Here's a new version of
this patch.


Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Users were confused by the driver being called "aoe-2.6-$version".
This form looks less like a Linux kernel version number.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoemain.c	2006-01-05 11:30:14.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c	2006-01-05 11:30:15.000000000 -0500
@@ -89,7 +89,7 @@
 	}
 
 	printk(KERN_INFO
-	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
+	       "aoe: aoe_init: AoE v%s initialised.\n",
 	       VERSION);
 	discover_timer(TINIT);
 	return 0;




-- 
  Ed L Cashin <ecashin@coraid.com>

