Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVBRPYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVBRPYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:24:30 -0500
Received: from [195.23.16.24] ([195.23.16.24]:20357 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261208AbVBRPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:24:26 -0500
Message-ID: <421608A8.60204@grupopie.com>
Date: Fri, 18 Feb 2005 15:24:24 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
Cc: franck.bui-huu@innova-card.com, linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com> <421604DD.4080809@grupopie.com> <4216068E.90205@microgate.com>
In-Reply-To: <4216068E.90205@microgate.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Paulo Marques wrote:
> 
>> Paul Fulghum wrote:
>>
>>> No, it limits the size to 80 bytes,
>>> which is the size of buf.
>>>
>>> sizeof returns the size of the char array buf[80]
>>> (standard C)
>>
>>
>> Looking at the code, I think Franck is right. buf is a "const unsigned 
>> char *" for which sizeof(buf) is the size of a pointer.
> 
> 
> What kernel version are you looking at?
> I'm looking at 2.4.20 n_tty.c opost_block() and
> buf is a char array.

Oops, this should have been clarified sooner...

I was looking at a 2.6.11-rc2 tree I have hanging around here. So maybe 
the "buf" type was changed and the condition remained, and that produced 
the bug.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
