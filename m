Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSFQQ7K>; Mon, 17 Jun 2002 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSFQQ7J>; Mon, 17 Jun 2002 12:59:09 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56924 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316574AbSFQQ7I>; Mon, 17 Jun 2002 12:59:08 -0400
Date: Tue, 18 Jun 2002 02:26:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: rml@mvista.com, alan@lxorguk.ukuu.org.uk, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
Message-Id: <20020618022630.17a907b4.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0206170503380.2941-100000@e2>
References: <1024271844.1476.26.camel@sinai>
	<Pine.LNX.4.44.0206170503380.2941-100000@e2>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002 05:24:30 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:

> > >  - sched_setaffinity() & sched_getaffinity() syscalls on x86.
> >
> > Do we want to introduce this into 2.4 now?  I realize 2.4-ac is not 2.4
> > proper, but if there is a chance this interface could change...
> 
> the setaffinity()/getaffinity() interface looks pretty robust, i dont
> expect any changes

There's one coming.  In 2.5.soon, you'll need to handle the "CPU going away"
signal, otherwise your process will abort as someone downs a CPU.

The problem with backporting one and not the other, is that apps can't be
written correctly for 2.4 and 2.5 8(

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
