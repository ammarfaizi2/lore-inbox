Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263394AbUKZWIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUKZWIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbUKZWIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:08:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:30336 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263615AbUKZTvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:51:32 -0500
Message-ID: <41A74AC1.8040208@dif.dk>
Date: Fri, 26 Nov 2004 16:24:49 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Any reason why we don't initialize all members of struct Xgt_desc_struct
 in doublefault.c ?
References: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost> <41A7483F.9010302@pobox.com>
In-Reply-To: <41A7483F.9010302@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Jesper Juhl wrote:
> 
>> Yes, this is nitpicking, but I just can't leave small corners like 
>> this unpolished ;)
>>
>> in arch/i386/kernel/doublefault.c you will find this (line 20) :
>>
>> struct Xgt_desc_struct gdt_desc = {0, 0};
>>
>> but, struct Xgt_desc_struct has 3 members,
>> struct Xgt_desc_struct {
>>         unsigned short size;
>>         unsigned long address __attribute__((packed));
>>         unsigned short pad;
>> } __attribute__ ((packed));
>>
>> so why only initialize two of them explicitly?
> 
> 
> 'pad' is a dummy variable... nobody cares about its value.
> 
Ok, good reason. Thank you for taking the time to reply.

--
Jesper Juhl
