Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290327AbSAPBXS>; Tue, 15 Jan 2002 20:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290334AbSAPBWF>; Tue, 15 Jan 2002 20:22:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:12296 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290327AbSAPBU6>;
	Tue, 15 Jan 2002 20:20:58 -0500
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115194316.I17477@redhat.com>
In-Reply-To: <20020115192048.G17477@redhat.com>
	<Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com> 
	<20020115194316.I17477@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 20:24:22 -0500
Message-Id: <1011144263.8754.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 19:43, Benjamin LaHaise wrote:
> +#ifndef __ASM__ATOMIC_H
> +#include <asm/atomic.h>
> +#endif

gcc -D__KERNEL__ -I/home/rml/src/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o brlock.o brlock.c
brlock.c:21: initializer element is not constant
brlock.c:21: (near initialization for `__brlock_array[0][0]')
... for all the [x][y] elements ...
brlock.c:21: initializer element is not constant
brlock.c:21: (near initialization for `__brlock_array[31]')

I get this compile error under 2.5.3-pre1, too.  System is SMP.  2.5.2
worked fine.  I don't see a thing in the patch that would cause this ...

	Robert Love

