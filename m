Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHYIBQ>; Sun, 25 Aug 2002 04:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHYIBQ>; Sun, 25 Aug 2002 04:01:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317066AbSHYIBP>; Sun, 25 Aug 2002 04:01:15 -0400
Date: Sun, 25 Aug 2002 09:05:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020825090522.A21314@flint.arm.linux.org.uk>
References: <1030232838.1451.99.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030232838.1451.99.camel@ldb>; from ldb@ldb.ods.org on Sun, Aug 25, 2002 at 01:47:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> ./drivers/acorn/block/fd1772.c

False positive; set_head_settle_flag is declared with code before use.
False positive; get_head_settle_flag is declared with code before use.
Correct positive; copy_buffer needs fixing, thanks for finding that.

> ./include/asm-arm/thread_info.h

False positive; current_thread_info is declared with code before use.

> ./include/asm-arm/current.h

False positive; get_current is declared with code before use.

> ./include/asm-arm/unistd.h

False positive; _syscall3 is a macro containing code.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

