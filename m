Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbULPU5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbULPU5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULPU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:57:38 -0500
Received: from terminus.zytor.com ([209.128.68.124]:25224 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262001AbULPU5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:57:35 -0500
Message-ID: <41C1F689.3090702@zytor.com>
Date: Thu, 16 Dec 2004 20:56:41 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>  <1101976424l.5095l.0l@werewolf.able.es>  <1101984361.28965.10.camel@tara.firmix.at>  <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es>  <1103158646.3585.35.camel@localhost.localdomain>  <41C0F67D.4000506@zytor.com> <1103203426.3804.16.camel@localhost.localdomain> <41C1F20E.2030903@zytor.com> <Pine.LNX.4.61.0412162151500.18903@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412162151500.18903@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>g++ is still much slower. We don't know how many bugs it would show up
>>>in the compiler and tools either, especially on embedded platforms.
>>>Finally the current kernel won't go through a C++ compiler because we
>>>use variables like "new" quite often.
>>
>>-Dnew=_New, problem solved.
> 
> 
> It's not that easy. Just when you expect it least, a few tiny sourcecode bits 
> already use new (in the C++ sense) and whoops:
> 	int *b = _New int[4];
> (self-explanatory)
> 

Unlikely, since we'd already have caught it, but either way -- hat's a 
bug too.  There shouldn't be any C++ code in the kernel, period.

	-hpa

