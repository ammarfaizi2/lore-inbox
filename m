Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQLTRGd>; Wed, 20 Dec 2000 12:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130536AbQLTRGZ>; Wed, 20 Dec 2000 12:06:25 -0500
Received: from flathead.gate.net ([216.219.246.5]:13996 "EHLO
	flathead.gate.net") by vger.kernel.org with ESMTP
	id <S129983AbQLTRGK>; Wed, 20 Dec 2000 12:06:10 -0500
Message-ID: <000d01c06aa2$e28ad750$7d1a24cf@master>
From: "Steve Grubb" <ddata@gate.net>
To: "Jeff Epler" <jepler@inetnebr.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master> <20001220100446.A1249@inetnebr.com>
Subject: Re: [Patch] performance enhancement for simple_strtoul
Date: Wed, 20 Dec 2000 11:35:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I thought about that. This would be my recommendation for glibc where the
general public may be doing scientific applications. But this is the kernel
and there are people that would reject my patch purely on the basis that it
adds precious bytes to the kernel. But since the kernel is "controllable" &
printf() and its variants only support 8, 10, & 16, perhaps a better
solution might be to trap the odd case and write something for it if its
that important, or simply don't allow it.

The base guessing part at the beginning of the function only supports base
8, 10, & 16. Therefore, the only way to require another base is to specify
it in the function call (param - unsigned int base). A quick scan of the
current linux source shows no one using something odd. So...

If the maintainers of vsprintf.c want support for all number bases, that's
fine with me. Just say the word & I'll gen up another patch...but it will be
more bytes.

Cheers,
Steve Grubb


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
