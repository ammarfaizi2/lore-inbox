Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbRHKQDQ>; Sat, 11 Aug 2001 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268427AbRHKQC4>; Sat, 11 Aug 2001 12:02:56 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:23822 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268382AbRHKQCy>;
	Sat, 11 Aug 2001 12:02:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sat, 11 Aug 2001 16:20:28 +0100."
             <20010811162028.A2732@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 02:03:00 +1000
Message-ID: <2286.997545780@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 16:20:28 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:
>> * Create arch/$(ARCH)/offsets.c containing code like this, from
>>   arch/i386/offsets.c.  This should be the standard format on all
>>   architectures, the only difference should be the list of fields to
>>   generate.
>
>I'm sorry, the ARM version of GCC does not support %c0 in a working
>state.  The way we generate the offsets on ARM is here to stay for
>the next few years until GCC 3 has stabilised well enough for use
>with the kernel, and the ARM architecture specifically.
>
>Please don't rely on %c0 working.

If you have to use %0 instead of %c0, that is all right.  Just remove
the extra '$' in the Makefile as arch/arm/tools/Makefile already does.
I would still like to see arm in 2.5 using the same style as i386,
including printing the offset in decimal and hex together with the
comment.  But that is just style, the important thing is to generate
assembler offsets so that kbuild can correctly track the dependencies.

