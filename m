Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSAZBV1>; Fri, 25 Jan 2002 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSAZBVS>; Fri, 25 Jan 2002 20:21:18 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:50564 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S288327AbSAZBVH>; Fri, 25 Jan 2002 20:21:07 -0500
Date: Sat, 26 Jan 2002 04:20:49 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre5 -- "pcilynx.c:638: invalid operands to binary &"  and  "pcilynx.c:650: `cards' undeclared"
Message-Id: <20020126042049.125616e0.johnpol@2ka.mipt.ru>
In-Reply-To: <1011979851.1261.9.camel@stomata.megapathdsl.net>
In-Reply-To: <1011932306.18088.162.camel@stomata.megapathdsl.net>
	<20020125123711.0f0ebc61.johnpol@2ka.mipt.ru>
	<1011979851.1261.9.camel@stomata.megapathdsl.net>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002 09:30:50 -0800
Miles Lane <miles@megapathdsl.net> wrote:

> Hi Evgeniy,
> 
> I get this error with the patch applied:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
> pcilynx.o pcilynx.c
> pcilynx.c: In function `mem_open':
> pcilynx.c:644: invalid operands to binary &
> pcilynx.c: In function `add_card':
> pcilynx.c:1520: incompatible types in assignment
> make[2]: *** [pcilynx.o] Error 1

I hope this patch will hel you.
Please apply and send feedback.
Good luck.
BTW, it probably won't work in 644 string, and if it will happen, than
Dave Jones tree is also broken.

P.S. It will not probably be applied, so enter
./drivers/ieee1394/pcilynx.c by hands. Sorry.

> 
> Thanks,
> 	Miles
> 

	Evgeniy Polyakov ( s0mbre ).
