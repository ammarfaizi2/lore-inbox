Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUFBU2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUFBU2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUFBU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:28:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264095AbUFBUWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:22:52 -0400
Message-ID: <40BE370C.9010800@pobox.com>
Date: Wed, 02 Jun 2004 16:22:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use new msleep() in ADT746x driver
References: <200405291908.i4TJ8Acm011281@hera.kernel.org>	 <40B8EA88.6030607@pobox.com> <1085873203.2140.21.camel@gaston>
In-Reply-To: <1085873203.2140.21.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Sun, 2004-05-30 at 05:54, Jeff Garzik wrote:
> 
>>Linux Kernel Mailing List wrote:
>>
>>>diff -Nru a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
>>>--- a/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
>>>+++ b/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
>>>@@ -246,8 +246,7 @@
>>> 
>>> 	while(monitor_running)
>>> 	{
>>>-		set_task_state(current, TASK_UNINTERRUPTIBLE);
>>>-		schedule_timeout(2*HZ);
>>>+		msleep(2000);
>>
>>
>>IMO this is moving the code away from what the coder appeared to intend.
>>
>>A "sleep(2)" would be preferred, and more clear.
> 
> 
> This patch was done by the original author of the driver


Well, I think the author is making his driver less readable...  "2 
seconds" is more clear than "2000 msec", and I am willing to bet that 
sleep() would have been used, had it existed.

	Jeff


