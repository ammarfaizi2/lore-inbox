Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbREPNwW>; Wed, 16 May 2001 09:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbREPNwM>; Wed, 16 May 2001 09:52:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:65008 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S261963AbREPNwH>; Wed, 16 May 2001 09:52:07 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: eccesys@topmail.de, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: rwsem, gcc3 again 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Wed, 16 May 2001 14:54:02 +0200." <20010516145402.B3725@athlon.random> 
Date: Wed, 16 May 2001 14:52:04 +0100
Message-ID: <10983.990021124@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrea:

Here you go:

/usr/local/bin/gcc -D__KERNEL__ -I/inst-kernels/linux-2.4.5-pre2-aa/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/inst-kernels/linux-2.4.5-pre2-aa/include/asm/rwsem_xchgadd.h:51: inconsistent
operand constraints in an `asm'

I've lit fires underneath some of our gcc people, and they say it's definitely
a bug in gcc. They're currently looking at it.

David
