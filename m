Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSBJEYG>; Sat, 9 Feb 2002 23:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSBJEXt>; Sat, 9 Feb 2002 23:23:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11539 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289272AbSBJEXn>; Sat, 9 Feb 2002 23:23:43 -0500
Message-ID: <3C65F5B3.5010006@zytor.com>
Date: Sat, 09 Feb 2002 20:23:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C659D8A.37EA0155@zip.com.au> from "Andrew Morton" at Feb 09, 2002 02:07:06 PM <E16Zjw9-0000Dr-00@the-village.bc.nu> <3C65F523.FDDB7FA@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Alan Cox wrote:
> 
>>>This works for me, from in-kernel as well as in-module.  It'd
>>>be good if someone more familiar with x86 could check it over.
>>>
>>This looks a really bad reversion. The CONFIG_DEBUG_BUGVERBOSE ifdef saves
>>over 70K of memory on my standard kernel build.
>>
> 
> About the time the 70k claim was made, I moved the printk out-of-line,
> so things got not so bad.  However, with my (large) kernel build, on
> egcs-1.1.2:
> 
> non-verbose BUG:
>         2589971  293436  373404 3256811  31b1eb vmlinux
> verbose BUG:
>         2709055  293436  373404 3375895  338317 vmlinux
> Patched:
>         2694537  293436  373404 3361377  334a61 vmlinux
> 
> Which is 100k, which is preposterous.
> 


Use "size" to determine the actual size, or strip the binary.

	-hpa


