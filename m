Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289358AbSAJJjS>; Thu, 10 Jan 2002 04:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289360AbSAJJjJ>; Thu, 10 Jan 2002 04:39:09 -0500
Received: from CPE00E02915899A.cpe.net.cable.rogers.com ([24.112.88.234]:45195
	"EHLO mokona.furryterror.org") by vger.kernel.org with ESMTP
	id <S289358AbSAJJi5>; Thu, 10 Jan 2002 04:38:57 -0500
From: uixjjji1@umail.furryterror.org (Zygo Blaxell)
Subject: Re: Moving zlib so that others may use it
Date: 10 Jan 2002 04:37:00 -0500
Organization: A poorly-maintained Debian GNU/Linux InterNetNews site
Message-ID: <a1jnbs$r0s$1@shippou.furryterror.org>
In-Reply-To: <24080.1010637887@kao2.melbourne.sgi.com> <3C3D22F8.1080201@acm.org>
NNTP-Posting-Host: 10.215.3.77
X-Header-Mangling: Original "From:" was <zblaxell@shippou.furryterror.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C3D22F8.1080201@acm.org>, Corey Minyard  <minyard@acm.org> wrote:
>Keith Owens wrote:
>
>>On Wed, 09 Jan 2002 22:23:31 -0600, 
>>Corey Minyard <minyard@acm.org> wrote:
>>>Keith Owens wrote:
[...]
>Building zlib as a
>>module guarantees that you cannot use it in a boot loader, forcing you
>>to maintain multiple versions of zlib.c.  If you are going to use one
>>version of zlib then you should try to handle bootloaders as well.
[...]
>I don't know about the bootloaders.  I'm not sure you can make the 
>requirement
>to have them compiled the same as the kernel, since they may have different
>compilation requirements in the boot loader.

Ummm, you can't use an in-kernel anything in a bootloader.  How do you
uncompress an in-kernel zlib.o without an out-of-kernel zlib.o lying
around somewhere?

The closest thing to a zlib.o shared between bootloader and kernel would
be to build one zlib.o and then perhaps copy the compiled binary from the
kernel to the bootloader (thus having only one zlib.c but two zlib.o) or
link it from the bootloader to the kernel once the kernel is uncompressed.

-- 
Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
GPG = D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD
