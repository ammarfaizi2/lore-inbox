Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSAUCZu>; Sun, 20 Jan 2002 21:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAUCZl>; Sun, 20 Jan 2002 21:25:41 -0500
Received: from zok.SGI.COM ([204.94.215.101]:31623 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289007AbSAUCZa>;
	Sun, 20 Jan 2002 21:25:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Sun, 20 Jan 2002 18:04:00 -0800."
             <3C4B7710.6C518006@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 13:25:18 +1100
Message-ID: <324.1011579918@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002 18:04:00 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>ksymoops doesn't know what modules were loaded at the time
>of the crash, and it doesn't know where they were loaded.

/var/log/ksymoops.  man insmod and look for ksymoops assistance.

>The `klogd -x' problem has been with us for *years* and
>distributors still persist in turning it on.

Tell me about it :(.

>It assumes too much.  Arjan has a kksymoops thingy which does the symbol
>resolution at crash-time.

It can only get symbols that are in /proc/ksyms, i.e. the exported
symbols.  Proper crash analysis needs the full symbol table.

>It also
>handles the common case where the running vmlinux/System.map/etc no longer
>exist.

So does ksymoops, with reduced detail because it only has exported
symbols.

>I would prefer that all this become easier, simpler and more reliable.
>We need a damn good reason for deprecating statically linked kernels
>and certainly none has been presented yet.

That is a different problem.  Saying that modular kernels cause
problems for debugging is not a good enough reason to deprecate modular
kernels, all the problems have been solved.

