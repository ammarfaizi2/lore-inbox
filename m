Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRDWWKd>; Mon, 23 Apr 2001 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDWWKZ>; Mon, 23 Apr 2001 18:10:25 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:6662 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S132425AbRDWWIr>; Mon, 23 Apr 2001 18:08:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: rwsem.o undefined reference to __builtin_expect
In-Reply-To: <9c18id$bb$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.33.0104231211530.519-100000@boston.corp.fedex.com> <9c18id$bb$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010423220841.949546808@mail.clouddancer.com>
Date: Mon, 23 Apr 2001 15:08:41 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In list.kernel, you wrote:
>
>
>cannot compile 2.4.4-pre6. This may have been reported, but I
>haven't seen it.

There was a solution mentioned Saturday.


>rwsem.o(.text+0x30): undefined reference to `__builtin_expect'
>rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
>make: *** [vmlinux] Error 1

in asm-alpha/compiler.h you will find a definition.  The above
solution created a new file (asm-i386/compiler.h) with the definition,
I just added it to rwsem.c.


BTW: 2.4.4-pre6 is the fastest kernel yet!  YMMV

