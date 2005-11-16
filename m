Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVKPGjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVKPGjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKPGjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:39:20 -0500
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:48231 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbVKPGjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:39:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N0MO5yXyAgg8V9U6Ygdgh9wzeMsDG5F9ZjEjoqPZEehkj4JIx/xzdJDcCkus47m5Ijy+sxefhYnEkhESkUKCT45CjF4QPa8TzE11CjfzFwdyCL2xduSBpZ0Rm/PQfPnJMVSqYGxv+ZK8n8Y7AFZ9Dc/kJnIcU5dFJOBRfq6ugho=  ;
Message-ID: <437AD413.9050805@rogers.com>
Date: Wed, 16 Nov 2005 01:39:15 -0500
From: Dwaine Garden <DwaineGarden@rogers.com>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: saa711x driver doesn't need segment.h
References: <20051110221411.GA26539@redhat.com> <4373C7B4.2000509@linuxtv.org>
In-Reply-To: <4373C7B4.2000509@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Krufky wrote:
> Dave Jones wrote:
>
>> This breaks compilation on non-x86 architectures,
>> and isn't even used.
>>
>> Signed-off-by: Dave Jones <davej@redhat.com>
>>
>> --- linux-2.6.14/drivers/media/video/saa711x.c~    2005-11-10 
>> 15:27:05.000000000 -0500
>> +++ linux-2.6.14/drivers/media/video/saa711x.c    2005-11-10 
>> 15:27:33.000000000 -0500
>> @@ -36,7 +36,6 @@
>> #include <asm/pgtable.h>
>> #include <asm/page.h>
>> #include <linux/sched.h>
>> -#include <asm/segment.h>
>> #include <linux/types.h>
>> #include <asm/uaccess.h>
>> #include <linux/videodev.h>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>  
>>
> Acked-by: Michael Krufky <mkrufky@m1k.net>
>
> Andrew-
>
> Due to the above fix, please revert:
>
> saa711x-is-busted-on-ppc64.patch
>
> Thank you.
>
Just tested out saa711x module with the USBVision driver and it works 
perfectly.   It's nice to have this module included with the v4l.


