Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRABUlk>; Tue, 2 Jan 2001 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131720AbRABUlb>; Tue, 2 Jan 2001 15:41:31 -0500
Received: from fe5.southeast.rr.com ([24.93.67.52]:51721 "EHLO
	mail5.triad.rr.com") by vger.kernel.org with ESMTP
	id <S131468AbRABUlW>; Tue, 2 Jan 2001 15:41:22 -0500
Message-ID: <3A523635.8080003@triad.rr.com>
Date: Tue, 02 Jan 2001 15:12:37 -0500
From: Ghadi Shayban <ghad@triad.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-prerelease i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Error compiling 2.4 with CVS gcc on Athlon
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea, but I'm guessing this isn't a gcc bug.  Here's where my 
build fails:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=athlon     -c -o mmx.o mmx.c
{standard input}: Assembler messages:
{standard input}:139: Error: bad register name `%%mm0'
make[2]: *** [mmx.o] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
make: *** [_dir_arch/i386/lib] Error 2


I thought maybe "mmx" is now named something else in the new gcc, but 
compiling it with -march=i686 doesn't change anything.

Ghadi Shayban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
