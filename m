Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSHLIVQ>; Mon, 12 Aug 2002 04:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSHLIVQ>; Mon, 12 Aug 2002 04:21:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:12236 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317506AbSHLIVP>;
	Mon, 12 Aug 2002 04:21:15 -0400
Date: Mon, 12 Aug 2002 18:23:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
Message-Id: <20020812182325.52324305.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain>
References: <20020812173404.39d3abab.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002 12:07:19 +0200 (CEST) Ingo Molnar <mingo@elte.hu> wrote:
>
> you can save/restore 0x40 in kernel-space if you need to no problem.

I guess I could around every BIOS call ...

Also, Alan (Cox) will say that's OK until he does APM on SMP on broken
BIOS's :-)

We could also just say that we no longer support those broken BIOS's ...

> so you are using the kernel's GDT in real mode as well?

No. The problem is that there are some BIOS's that contain code that (even
though they are called in protected mode) load 0x40 into ds and expect to
be able to reference stuff ...  Causes really interesting OOPSs :-(

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
