Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVAJQ7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVAJQ7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVAJQ7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:59:52 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:5263 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262327AbVAJQ7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:59:49 -0500
Message-ID: <41E2B398.7040507@tiscali.de>
Date: Mon, 10 Jan 2005 17:55:52 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org> <20050110004313.GB1483@stusta.de>
In-Reply-To: <20050110004313.GB1483@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sun, Jan 09, 2005 at 12:19:09PM -0800, Linus Torvalds wrote:
>  
>
>>On Sun, 9 Jan 2005, Arjan van de Ven wrote:
>>    
>>
>>>Instead of fixing this inconsistency, I decided to remove it entirely,
>>>explicit memcpy() and memmove() are prefered anyway (welcome to the 1990's)
>>>and nothing in the kernel is using these functions, so this saves code size
>>>as well for everyone.
>>>      
>>>
>>The problem is that at least some gcc versions would historically generate
>>calls to "bcopy" on alpha for structure assignments. Maybe it doesn't any
>>more, and no such old gcc versions exist any more, but who knows?
>>...
>>    
>>
>
>include/asm-alpha/string.h says:
>
>  /*
>   * GCC of any recent vintage doesn't do stupid things with bcopy.
>   * EGCS 1.1 knows all about expanding memcpy inline, others don't.
>   *
>   * Similarly for a memset with data = 0.
>   */
>
>
>And Arjan's patch is pretty low-risk:
>
>If it breaks on any architecture with any supported compiler (>= 2.95), 
>it will break at compile time and there will pretty fast be reports of 
>this breakage in which case it would be easy to revert his patch.
>
>
>  
>
>>		Linus
>>    
>>
>
>cu
>Adrian
>
>  
>
Jep and most people are using a newer gcc and newer glibc. Linux has to 
stay up2date, so I think it's the best choise to create a modern and 
clean (without broken functions) OS.

Matthias-Christian Ott
