Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVFWQb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVFWQb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVFWQb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:31:56 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:26067 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262610AbVFWQbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:31:52 -0400
Message-ID: <42BAE3B1.5010209@am.sony.com>
Date: Thu, 23 Jun 2005 09:30:41 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Woodhouse <dwmw2@infradead.org>, "Sean M. Burke" <sburke@cpan.org>,
       trivial@rustcorp.com.au
Subject: Re: PATCH: "Ok" -> "OK" in messages
References: <42985251.6030006@cpan.org> <1117279792.32118.11.camel@localhost.localdomain> <20050528125430.GB3870@ojjektum.uhulinux.hu>
In-Reply-To: <20050528125430.GB3870@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

� wrote:

>> While we are at it, what about changing this string to something
>> language-neutral, like this:
>>
>> diff -Naurdp a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
>> --- a/arch/i386/boot/compressed/misc.c	2004-04-04 05:37:23.000000000 +0200
>> +++ b/arch/i386/boot/compressed/misc.c	2004-05-09 23:18:06.000000000 +0200
>> @@ -10,6 +10,7 @@
>>   */
>>
>>  #include <linux/linkage.h>
>> +#include <linux/version.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/tty.h>
>>  #include <video/edid.h>
>> @@ -373,9 +374,9 @@ asmlinkage int decompress_kernel(struct
>>  	else setup_output_buffer_if_we_run_high(mv);
>>
>>  	makecrc();
>> -	putstr("Uncompressing Linux... ");
>> +	putstr("Linux " UTS_RELEASE);
>>  	gunzip();
>> -	putstr("Ok, booting the kernel.\n");
>> +	putstr("\n");
>>  	if (high_loaded) close_output_buffer_if_we_run_high(mv);
>>  	return high_loaded;
>>  }


Language neutrality is not a goal for kernel messages,
that I'm aware of.  I disagree with this change because
it yields a net reduction in understanding what's going
on during booting.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
