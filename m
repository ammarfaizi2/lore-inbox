Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270151AbTGPGHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGPGHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:07:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:1508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270151AbTGPGHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:07:18 -0400
Date: Tue, 15 Jul 2003 23:22:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-Id: <20030715232233.7d187f0e.akpm@osdl.org>
In-Reply-To: <20030716061642.GA4032@triplehelix.org>
References: <20030715225608.0d3bff77.akpm@osdl.org>
	<20030716061642.GA4032@triplehelix.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@triplehelix.org> wrote:
>
> There are a mountain of warnings when compiling, and I've traced it to
>  asm-i386/irq.h, i THINK... for example:
> 
>  In file included from include/asm/thread_info.h:13,
>                   from include/linux/thread_info.h:21,
>                   from include/linux/spinlock.h:12,
>                   from include/linux/irq.h:17,
>                   from arch/i386/kernel/cpu/mcheck/winchip.c:8:
>  include/asm/processor.h:66: warning: padding struct size to alignment boundary
>  include/asm/processor.h:339: warning: padding struct to align `info'
>  include/asm/processor.h:401: warning: padding struct to align `i387'

Oh, all right, I forgot to set aside the requisite eighteen hours to build
the kernel with gcc-3.x.  Sorry bout that.

Just ignore them, or revert wpadded.patch.

