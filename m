Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVBRP22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVBRP22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBRP21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:28:27 -0500
Received: from [195.23.16.24] ([195.23.16.24]:27525 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261388AbVBRP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:27:49 -0500
Message-ID: <42160973.5070808@grupopie.com>
Date: Fri, 18 Feb 2005 15:27:47 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: Paul Fulghum <paulkf@microgate.com>, franck.bui-huu@innova-card.com,
       linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com> <4216068E.90205@microgate.com> <Pine.LNX.4.61.0502181020480.23519@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502181020480.23519@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Fri, 18 Feb 2005, Paul Fulghum wrote:
> 
>> Paulo Marques wrote:
>>
>>> Paul Fulghum wrote:
>>>
>>>> No, it limits the size to 80 bytes,
>>>> which is the size of buf.
>>>>
>>>> sizeof returns the size of the char array buf[80]
>>>> (standard C)
>>>
>>>
>>> Looking at the code, I think Franck is right. buf is a "const 
>>> unsigned char *" for which sizeof(buf) is the size of a pointer.
>>
>>
>> What kernel version are you looking at?
>> I'm looking at 2.4.20 n_tty.c opost_block() and
>> buf is a char array.
>>
>> -- 
>> Paul Fulghum
>> Microgate Systems, Ltd.
> 
> 
> Ahaa!  That's how the bug got introduced. It used to be an
> array and then it got changed to a pointer! linux-2.4.26
> also shows a local array.

Yes, just looked at the revision history in linux.bkbits.net and Linus 
just fixed this 67 hours ago... So we're too late :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
