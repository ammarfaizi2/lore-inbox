Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUJOCJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUJOCJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUJOCJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:09:46 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15597 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268126AbUJOCJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:09:41 -0400
Date: Fri, 15 Oct 2004 11:11:08 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 1/5][Diskdump] IPF(IA64) support
In-reply-to: <1097804121.22673.43.camel@localhost.localdomain>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Message-id: <34C4B25C3BFAE4indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1097804121.22673.43.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, 15 Oct 2004 11:35:22 +1000, Rusty Russell wrote:

>On Fri, 2004-07-23 at 19:53, Takao Indoh wrote:
>> +static unsigned int fallback_on_err = 1;
>> +static unsigned int allow_risky_dumps = 1;
>> +static unsigned int block_order = 2;
>> +static int sample_rate = 8;
>> +module_param(fallback_on_err, uint, 0);
>> +module_param(allow_risky_dumps, uint, 0);
>> +module_param(block_order, uint, 0);
>> +module_param(sample_rate, int, 0);
>
>Hi Takao!
>
>	Are you sure you want "uint" for fallback_on_err and allow_risky_dumps
>and not "bool"?  Also, I suggest "0400" as permissions so you can read
>them out of sysfs; maybe even 0600 if these parameters can be changed
>after loading.

Thanks for comment.

The type of fallback_on_err and allow_risky_dumps is bool.
The latest version of diskdump (released on 28th Aug) is as follows.

+static int fallback_on_err = 1;
+static int allow_risky_dumps = 1;
+static unsigned int block_order = 2;
+static int sample_rate = 8;
+module_param_named(fallback_on_err, fallback_on_err, bool, S_IRUGO|S_IWUSR);
+module_param_named(allow_risky_dumps, allow_risky_dumps, bool, S_IRUGO|S_IWUSR);
+module_param_named(block_order, block_order, uint, S_IRUGO|S_IWUSR);
+module_param_named(sample_rate, sample_rate, int, S_IRUGO|S_IWUSR);


Regards,
Takao Indoh
