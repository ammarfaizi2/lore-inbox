Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVA0BXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVA0BXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVA0ADA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:03:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55293 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262345AbVAZUdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 15:33:19 -0500
Message-ID: <41F7FE8A.2070508@mvista.com>
Date: Wed, 26 Jan 2005 13:33:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
References: <41F6F1D5.90601@mvista.com> <20050126205619.4c0b41fa.khali@linux-fr.org>
In-Reply-To: <20050126205619.4c0b41fa.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

>Hi Mark,
>

Thanks for the commenting, Jean.

><snip>
>
>  
>
>>+config I2C_MV64XXX
>>+	tristate "Marvell mv64xxx I2C Controller"
>>+	depends on I2C && MV64X60
>>    
>>
>
>&& EXPERIMENTAL?
>

Yes, I guess that's the correct thing to do.  I'll add that.

>>diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
>>--- a/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
>>+++ b/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
>>@@ -200,6 +200,7 @@
>> 
>> #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
>> #define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
>>+#define I2C_ALGO_MV64XXX 0x170000       /* Marvell mv64xxx i2c ctlr     */
>>    
>>
>
>0x170000 is reserved within the legacy i2c project for an USB algorithm,
>and 0x180000 for virtual busses. Could you please use 0x190000 instead,
>so as to avoid future collisions?
>

Absolutely.  I was unaware of the other uses.

>  
>
>>-#define MV64340_I2C_SOFT_RESET                                      0xc01c
>>+#define	MV64XXX_I2C_CTLR_NAME					"mv64xxx i2c"
>>+#define MV64XXX_I2C_OFFSET					    0xc000
>>+#define MV64XXX_I2C_REG_BLOCK_SIZE				    0x0020
>>    
>>
>
>You have a tab instead of space before MV64XXX_I2C_CTLR_NAME, it seems.
>Also, you want to align the numerical values using only tabs, no space.
>  
>

Oops.  I'll fix that too and repost later today.

Mark

