Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVKSWHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVKSWHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVKSWHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:07:19 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:46564 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750858AbVKSWHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:07:17 -0500
Message-ID: <437FAFD4.7020304@free.fr>
Date: Sat, 19 Nov 2005 23:05:56 +0000
From: =?ISO-8859-1?Q?St=E9phane_BAUSSON?= <stephane.bausson@free.fr>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fail to buil linux-2.6.14
References: <437CF690.5060206@free.fr> <Pine.LNX.4.63.0511172335570.15546@deepthought.mydomain>
In-Reply-To: <Pine.LNX.4.63.0511172335570.15546@deepthought.mydomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed it by increasing the the 0x400 offset in 
arch/i386/kernel/vsyscall.lds to 0xb00 ...
I do not understand why this issue is specific to my config.



Ken Moffat wrote:
> On Thu, 17 Nov 2005, Stéphane BAUSSON wrote:
>
>> Hi, I am failing to build 2.6.14, any idea or direction for 
>> investigation ?
>>
>> ======================================
>> /local/gnu/binutils/bin/ld: section .text [ffffe400 -> ffffe45f] 
>> overlaps section .dynstr [ffffe17c -> ffffe9cd]
>> /local/gnu/binutils/bin/ld: section .note [ffffe460 -> ffffe477] 
>> overlaps section .dynstr [ffffe17c -> ffffe9cd]
>
>  Get a better binutils ?  I don't know what you've installed in 
> /local/gnu/binutils, but it clearly doesn't get along with the kernel 
> you've compiled.  Maybe it's broken (at least from a kernel 
> viewpoint), maybe it simply doesn't match the version of gcc you are 
> using.
>
> Ken

-- 
 stephane.bausson@free.fr  -  Lherm (31,France)

 
 

