Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWDLEH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWDLEH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 00:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDLEH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 00:07:59 -0400
Received: from mta203-rme.xtra.co.nz ([210.86.15.146]:47746 "EHLO
	mta203-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S1751337AbWDLEH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 00:07:58 -0400
X-Originating-IP: [139.80.27.22]
From: Zhiyi Huang <zhiyi6@xtra.co.nz>
Reply-To: hzy@cs.otago.ac.nz
Organization: Univ of Otago
To: "Hareesh Nagarajan" <hnagar2@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <zhiyi6@xtra.co.nz>
Subject: Re: Re: Slab corruption after unloading a module
Date: Wed, 12 Apr 2006 16:07:56 +1200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20060412040756.YSVZ11236.web3-rme.xtra.co.nz@[202.27.184.228]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> From: "Hareesh Nagarajan" <hnagar2@gmail.com>
> Date: 2006/04/12 Wed PM 03:51:22 GMT+12:00
> To: hzy@cs.otago.ac.nz
> CC: linux-kernel@vger.kernel.org,  zhiyi6@xtra.co.nz
> Subject: Re: Slab corruption after unloading a module
>
> Why don't you compile the kernel with  CONFIG_DEBUG_SLAB=y and see 
what the
> debug messages have to say?

Thanks for help. I already configured the kernel with CONFIG_DEBUG_SLAB=y, 
but I changed the current log level from 7 to 8. I got similar messages below. 
I still have no clue. The messages show nothing about my module. Any more 
suggestions?

Hello world from Template Module
temp device MAJOR is 252
Good bye from Template Module: 618 pages
Slab corruption: start=c7933c38, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01ac52d>](load_elf_interp+0xdd/0x2d0)
070: 6b 6b 6b 6b ac 3c 93 c7 ac 3c 93 c7 6b 6b 6b 6b
Prev obj: start=c7933b6c, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c7933d04, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01e58fa>](__journal_remove_checkpoint+0x4a/0xa0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b


