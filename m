Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317201AbSFFWcp>; Thu, 6 Jun 2002 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317205AbSFFWco>; Thu, 6 Jun 2002 18:32:44 -0400
Received: from ivimey.org ([194.106.52.201]:26466 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S317201AbSFFWco>;
	Thu, 6 Jun 2002 18:32:44 -0400
Date: Thu, 6 Jun 2002 23:32:33 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Pavel Machek <pavel@ucw.cz>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove suser()
In-Reply-To: <20020606214840.GA1190@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0206062330480.16968-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Pavel Machek wrote:

>> diff -urN linux-2.5.20/include/linux/compatmac.h linux/include/linux/compatmac.h
>> --- linux-2.5.20/include/linux/compatmac.h	Sun Jun  2 18:44:41 2002
>> +++ linux/include/linux/compatmac.h	Tue Jun  4 13:57:33 2002
>> @@ -102,8 +102,6 @@
>>  
>>  #define my_iounmap(x, b)             (((long)x<0x100000)?0:vfree ((void*)x))
>>  
>> -#define capable(x)                   suser()
>> -
>>  #define tty_flip_buffer_push(tty)    queue_task(&tty->flip.tqueue, &tq_timer)
>
>This is not right I believe. You want to keep compatibility for older
>kernels.
>
>									Pavel

Why? The file being changed is in a particular kernel, not in, say, glibc; to 
require compatibilty btw. a file in kernel X and another in kernel Y seems 
stupid... but perhaps I misunderstand.

Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

