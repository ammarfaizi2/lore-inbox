Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUKKA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUKKA3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUKKA3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:29:11 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:36361 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262155AbUKKA2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:28:55 -0500
Message-ID: <4192B259.7070106@conectiva.com.br>
Date: Wed, 10 Nov 2004 22:29:13 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <len.brown@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
References: <4192A959.9020806@conectiva.com.br> <4192A9BF.2080606@conectiva.com.br> <4192ADF4.1050907@conectiva.com.br> <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> 
> On Wed, 10 Nov 2004, Arnaldo Carvalho de Melo wrote:
> 
>>This one compiles and links OK.
> 
> 
> Including when CONFIG_ACPI_BOOT is set? Does it see the prototype then? 
> Looks like <asm/acpi.h> should be included, but I assume it gets included 
> some other way?
> 
> Quite frankly, I think the whole thing is broken. #ifdef's inside code is 
> _evil_, and "platform_rename_gsi()" doesn't make sense as a name. I'll 
> apply your patch, but quite frankly, I think the ACPI layer is doing crap.
> 

Agreed, I leave this now to the ACPI guys, it may well be that the whole
case is to be ifdefed or something different, who knows. Just please
apply the one in the message I was looking for a brown paper bag (i.e.
the one with the #endif _before_ the break statement).

Ouch, time to make a hole for the nose, I need some air :o)

> Len, can you please use a more descriptive name, and have it be always 
> defined (make it an inline function that just becomes a no-op or 
> something).
> 
> 		Linus
> 
> 
