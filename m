Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317573AbSFIHJp>; Sun, 9 Jun 2002 03:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317574AbSFIHJp>; Sun, 9 Jun 2002 03:09:45 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:3591 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317573AbSFIHJo>;
	Sun, 9 Jun 2002 03:09:44 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206090709.g5979iK439624@saturn.cs.uml.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
To: hirofumi@mail.parknet.co.jp (OGAWA Hirofumi)
Date: Sun, 9 Jun 2002 03:09:44 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <87r8jhc685.fsf@devron.myhome.or.jp> from "OGAWA Hirofumi" at Jun 09, 2002 03:32:26 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> 1. app source code isn't supposed to use raw kernel headers
>> 2. existing executables are not affected
>> 3. the 2.5.xx series has already broken much more
>> 4. it's crud for the kernel; it's crud for user code
>> 5. the kernel shouldn't contain misc. user app code
>
> Why is there __KERNEL__ macro?

Long ago, it was considered OK to use the kernel headers
in app code. This is the case with Linux 2.0 and libc 5.
(it used to be OK to symlink /usr/include/linux into an
unmodified copy of the Linux kernel source)

There has been a weak effort to avoid breaking libc 5.

Using __KERNEL__ might make it easier to provide cleaned
headers for user code.

There has been talk of removing __KERNEL__ usage from
some of the header files.

