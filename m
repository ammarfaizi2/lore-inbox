Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUKFS1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUKFS1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUKFS1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:27:45 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:9107 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261375AbUKFS1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:27:43 -0500
Message-ID: <418D179D.50301@verizon.net>
Date: Sat, 06 Nov 2004 13:27:41 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw_random: Update printk()'s in hw_random.c
References: <20041105211912.17210.55119.84600@localhost.localdomain> <418D0623.8000302@pobox.com>
In-Reply-To: <418D0623.8000302@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [68.238.31.6] at Sat, 6 Nov 2004 12:27:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  /*
>>   * debugging macros
>>   */
>> -#undef RNG_DEBUG /* define to enable copious debugging info */
>> +#undef DEBUG /* define to enable copious debugging info */
> 
> 
> I think the '#undef DEBUG' line is supposed to precede all the 
> #includes, yes?
> 
> 

>>  static int rng_dev_open (struct inode *inode, struct file *filp);
>>  static ssize_t rng_dev_read (struct file *filp, char __user *buf, 
>> size_t size,
>> -                 loff_t * offp);
>> +        loff_t * offp);
> 
> 
> seemingly bogus whitespace change
> 
> 

>> -    bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & 
>> VIA_XSTORE_CNT_MASK;
>> +    bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) &
>> +            VIA_XSTORE_CNT_MASK;
> 
> 
> bogus whitespace change
> -


All right.  I'll back out the whitespace changes and move the #undef to the top of 
the #includes, and re-submit.
