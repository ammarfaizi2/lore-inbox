Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVCNTXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVCNTXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCNTXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:23:54 -0500
Received: from quark.didntduck.org ([69.55.226.66]:31413 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261747AbVCNTXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:23:48 -0500
Message-ID: <4235E4D5.5070506@didntduck.org>
Date: Mon, 14 Mar 2005 14:24:05 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Jakob Eriksson <jakov@vmlinux.org>, Andi Kleen <ak@muc.de>,
       Stas Sergeev <stsp@aknet.ru>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org, torvalds@osdl.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235AC0B.70507@vmlinux.org> <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503141158460.19270@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Mon, 14 Mar 2005, Jakob Eriksson wrote:
> 
>> Andi Kleen wrote:
>>
>>> Stas Sergeev <stsp@aknet.ru> writes:
>>>
>>>>> Another way of saying the same thing: I absolutely hate seeing
>>>>> patches that fix some theoretical issue that no Linux apps will ever
>>>>> care about.
>>>>>
>>>> No, it is not theoretical, but it is mainly
>>>> about a DOS games and an MS linker, as for
>>>> me. The things I'd like to get working, but
>>>> the ones you may not care too much about:)
>>>> The particular game I want to get working,
>>>> is "Master of Orion 2" for DOS.
>>>>
>>>
>>> How about you just run it in dosbox instead of dosemu ?
>>>
>>
>> Yes, that's a solution of course, but it is a bit like saying why
>> not use Open Office instead of MS Word.
>>
>> A long term goal of wine is to support DOS apps to. Of course
>> it's not a priority, but it's there.
>>
>> regards,
>> Jakob
>>
> 
> Can you tell me how the invisible high-word (invisible in VM-86, and
> in real mode) could possibly harm something running in VM-86 or
> read-mode ???  I don't even think it's a BUG. If the transition
> into and out of VM-86 doesn't handle the fact that the high-word
> of the stack hasn't been used in VM-86, then that piece of code
> is bad (the SP isn't even the same stack, BTW).

Because even in 16-bit mode (real, vm86 or 16-bit protected) you can use 
32-bit instructions, with an operand and/or address size override 
prefix.  Of course this only works on 386 or later.

--
				Brian Gerst
