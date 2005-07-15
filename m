Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263237AbVGOI3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbVGOI3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGOI3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:29:54 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:64129
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263237AbVGOI3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:29:53 -0400
Message-ID: <42D7734D.9070204@prodmail.net>
Date: Fri, 15 Jul 2005 13:56:53 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: omb@bluewin.ch, linux-kernel@vger.kernel.org
Subject: Re: Buffer Over-runs, was Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>	 <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>	 <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>	 <42D6ECED.7070504@khandalf.com>  <42D75A93.5010904@prodmail.net> <1121410260.3179.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1121410260.3179.3.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Fri, 2005-07-15 at 12:11 +0530, RVK wrote:
>
>  
>
>>Even in the presence of non-executable stack, Linux Torvalds explains
>>that "It's really easy. You do something like this: 1) overflow the
>>buffer on the stack, so that the return value is overwritten by a
>>pointer to the system() library function. 2) the next four bytes are
>>crap (a "return pointer" for the system call, which you don't care
>>about) 3) the next four bytes are a pointer to some random place in the
>>shared library again that contains the string "/bin/sh" (and yes, just
>>do a strings on the thing and you'll find it). Voila. You didn't have to
>>write any code, the only thing you needed to know was where the library
>>is loaded by default. And yes, it's library-specific, but hey, you just
>>select one specific commonly used version to crash. Suddenly you have a
>>root shell on the system. So it's not only doable, it's fairly trivial
>>to do. In short, anybody who thinks that the non-executable stack gives
>>them any real security is very very much living in a dream world. It may
>>catch a few attacks for old binaries that have security problems, but
>>the basic problem is that the binaries allow you to overwrite their
>>stacks. And if they allow that, then they allow the above exploit. It
>>probably takes all of five lines of changes to some existing exploit,
>>and some random program to find out where in the address space the
>>shared libraries tend to be loaded."
>>    
>>
>
>except this is no longer true really ;)
>
>randomisation for example makes this a lot harder to do.
>gcc level tricks to prevent buffer overflows are widely in use nowadays
>too (FORTIFY_SOURCE and -fstack-protector). The combination of this all
>makes it a LOT harder to actually exploit a buffer overflow on, say, a
>distribution like Fedora Core 4.
>
>
>  
>
Still is very new....not every one can immediately start using gcc 4.

rvk

>>rvk
>>
>>    
>>
>>>but your system is not compromised.
>>>
>>>One final point, in practice, you get lots of unwanted packets
>>>off the internet, and in general you do not want them on your
>>>internal net, both for performance and security reasons, if you
>>>drop them on your router or firewall then you dont need to
>>>worry if the remote app is mal-ware.
>>>
>>>--
>>>mit freundlichen Grüßen, Brian.
>>>
>>>.
>>>
>>>
>>>
>>>      
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>.
>
>  
>

