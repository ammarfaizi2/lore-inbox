Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbQLHDeV>; Thu, 7 Dec 2000 22:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQLHDeL>; Thu, 7 Dec 2000 22:34:11 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:44838 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130194AbQLHDd5>; Thu, 7 Dec 2000 22:33:57 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Joseph Cheek <joseph@cheek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: Your message of "Thu, 07 Dec 2000 17:23:51 -0800."
             <3A303827.AF486F37@cheek.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 14:03:18 +1100
Message-ID: <3276.976244598@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2000 17:23:51 -0800, 
Joseph Cheek <joseph@cheek.com> wrote:
>i'll check it out.  i'm compiling ksymoops now, is there a way to get it to
>work without a static libbfd?  all i've got is a libbfd.so, and i'm going to
>need to recompile binutils if i must have a libbfd.a.

ksymoops/Makefile, change
$(CC) $(OBJECTS) $(CFLAGS) -Wl,-Bstatic -lbfd -liberty -Wl,-Bdynamic -o $@
to
$(CC) $(OBJECTS) $(CFLAGS) -lbfd -liberty -o $@

But you should have libbfd.a.  Debian splits binutils into binutils and
binutils-dev, libbfd.a might be in the latter.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
