Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUBSK7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbUBSK7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:59:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:64914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267189AbUBSK7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:59:38 -0500
Date: Thu, 19 Feb 2004 02:59:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       error27@email.com
Subject: Re: [Announce] Strace Test
Message-Id: <20040219025939.3cdc52b5.akpm@osdl.org>
In-Reply-To: <16436.38183.533759.45718@laputa.namesys.com>
References: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
	<16436.35563.593635.277584@laputa.namesys.com>
	<20040219023813.2d4b0ced.akpm@osdl.org>
	<16436.38183.533759.45718@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
>  Andrew Morton writes:
>   > Nikita Danilov <Nikita@Namesys.COM> wrote:
>   > >
>   > >  > Strace Test uses a modified version of strace 4.5.1.  
>   > >   > Instead of printing out information about system calls, 
>   > >   > the modified version calls the syscalls with improper 
>   > >   > values.
>   > > 
>   > >  It immediately DoSes kernel by calling sys_sysctl() with huge nlen:
>   > >  printk() consumes all CPU.
>   > 
>   > Something like this?
> 
>  On slow console (serial kgdb) this still would be problematic. I think
>  printk_ratelimit() is needed. But why this loop is needed at all? It
>  seems strange that syscall prints its arguments instead of just
>  returning -EINVAL.

It is kindly telling the user that the sysctl is obsolete.

I'll kill it.
