Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290849AbSAaCtU>; Wed, 30 Jan 2002 21:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290848AbSAaCtA>; Wed, 30 Jan 2002 21:49:00 -0500
Received: from [65.169.83.229] ([65.169.83.229]:19595 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S290846AbSAaCs5>; Wed, 30 Jan 2002 21:48:57 -0500
Date: Wed, 30 Jan 2002 20:48:09 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: linux/zutil.h
Message-ID: <20020131024809.GA12041@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.18pre2
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to do "make modules" on 2.5.3 it croaks when it gets to here:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.5.3/include/linux/modversions.h -I
/usr/src/linux-2.5.3/lib/zlib_deflate  -c -o deflate.o deflate.c
deflate.c:52: linux/zutil.h: No such file or directory
deflate.c:940: macro `UPDATE_HASH' used without args
deflate.c:1107: macro `UPDATE_HASH' used without args
In file included from deflate.c:53:
defutil.h:42: parse error before `ush'
defutil.h:42: warning: no semicolon at end of struct or union

This is followed by several pages of errors stemming from this problem.
I'm guessing the whole thing is because of this:

deflate.c:52: linux/zutil.h: No such file or directory

Ben Pharr
ben@benpharr.com

