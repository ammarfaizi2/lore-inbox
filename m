Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281204AbRKLB3A>; Sun, 11 Nov 2001 20:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281205AbRKLB2t>; Sun, 11 Nov 2001 20:28:49 -0500
Received: from zok.SGI.COM ([204.94.215.101]:18140 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281204AbRKLB2i>;
	Sun, 11 Nov 2001 20:28:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling manually 
In-Reply-To: Your message of "11 Nov 2001 16:57:41 -0000."
             <m3k7wxkzy2.fsf@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Nov 2001 12:28:19 +1100
Message-ID: <31888.1005528499@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2001 16:57:41 +0000, 
pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy) wrote:
>I'm trying to compile kernel 2.4.14.
>The problem is that the famous gcc 3.0.x bug of giving error when
>trying to compile 8139too.c is getting me crazy.
>The work around is to remove -O2 optimization.
>How can I compile the kernel with optimization except
>optimization for that particular file?

In drivers/net/Makefile, add this line _before_ include Rules.make.

CFLAGS_8139too.o += -O1

Warning: removing optimization can cause its own problems, some bits of
         the kernel assume that they are built with -O2.  YMMV.

