Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWGGXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWGGXec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGGXec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:34:32 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:63701 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S932403AbWGGXeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:34:31 -0400
Message-ID: <44AEEF9A.4060505@bizmail.com.au>
Date: Sat, 08 Jul 2006 09:34:50 +1000
From: YH <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@suers.sf.net, yudeh@rtunet.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Module link
References: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>	<20060706210805.b9e952ca.rdunlap@xenotime.net>	<2513.203.217.29.133.1152250423.squirrel@203.217.29.133> <17581.63026.514260.403228@hound.rchland.ibm.com>
In-Reply-To: <17581.63026.514260.403228@hound.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all responses. The file was modified from 
drivers/macintosh/therm_adt746x.c, the function call i2c_add_driver() in 
static int __init thermostat_init(void) caused a null point. In fact, 
all i2c related functions were not linked. The i2c-core.c has been built 
in kernel. How does the module therm_adt746x.ko link to i2c? I did not 
see that the module therm_adt746x.ko resolved symbol i2c_add_driver. Or, 
the symbols are resolved during insmod? I guess I try to figure out 
whether this problem is caused by building process in kernel or by 
module loading process in insmod (using BusyBox)?

Thank you.

Jim

Dave C Boutcher wrote:
> On Fri, 7 Jul 2006 15:33:43 +1000 (EST), yh@bizmail.com.au said:
> 
>>Thanks Randy. Let me clarify it.
>>I have a driver module (NewSerialModule.ko) and I build it for module
>>load. This driver module uses i2c functions. It was fine to init this
>>module in kernel 2.4 as the i2c functions are exported in i2c Makefile.
>>
>>In kernel 2.6, I loaded this module and got NULL point exception. I
>>checked the module map, all i2c functions are not linked. I also checked
>>i2c, there is no export for i2c in kernel 2.6. So, my question is how can
>>I link the dirvers/i2c to my driver module in drivers/char directory? How
>>to export a directory to be a library such as i2c? In general, how to link
>>another directory functions by a module in kernel 2.6?
> 
> 
> It is difficult for any of us to offer assistance unless you provide a
> pointer to your source code.
> 
> However, I will point out that the i2c functions are exported from
> drivers/i2c/i2c-core.c, so you should make sure you have that module
> either built into your kernel or loaded.
> 
> Dave B
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

