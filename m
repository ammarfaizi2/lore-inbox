Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316265AbSEVRUx>; Wed, 22 May 2002 13:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316268AbSEVRUx>; Wed, 22 May 2002 13:20:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31250 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316265AbSEVRUv>; Wed, 22 May 2002 13:20:51 -0400
Message-ID: <3CEBC496.9030900@evision-ventures.com>
Date: Wed, 22 May 2002 18:17:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AZoV-0002I7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>Anybody: if you've ever used /dev/ports, holler _now_.
> 
> 
> Holler. I posted a list of examples to linux-kernel already. iopl and ioperm
> are not portable in the way /dev/port is. ioperm/iopl also doesnt work
> with most scripting languages, java tools trying to avoid JNI etc

What?

#include <linux/io.h>
#include <stdio.h>
#include <stdlib.h>

int main(char *argv[], int argc)
{
	int port = aoit(argv[0]);
	 int byte = aoit(argv[1]);

	if (port > 0)
		return inb(port);		
	 else
			outb(port, byte);


		return 0;
}

and then syscall("/sbin/doportio")

Is certainly *NOT IMPOSSIBLE*. But it's of course too
much of a burden...

BTW> Under java it's rather hard to get around
CAP_RAWIO if you ask me without going down to JNI.

> I've seen it used in tools written in java, python, perl, even tcl
> 
> Other examples include libieee1284, the pic 16x84 programmer, hwclock,
> older kbdrate, /sbin/clock on machines that don't have /dev/rtc.

All the examples above are samples of bad coding practice - I have
uncovered already here in C what can be expected inside there!

> Not everything in the world is an x86, and not every app wants to be Linux/x86
> specific or use weird syscalls

Yes and in esp. everything in the world is a __m68000__!

