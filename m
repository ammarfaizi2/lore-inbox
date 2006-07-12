Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWGLHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGLHMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWGLHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:12:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWGLHMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:12:35 -0400
Date: Wed, 12 Jul 2006 00:12:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.18-rc1-mm1: as usual can not boot
Message-Id: <20060712001232.a31285e3.akpm@osdl.org>
In-Reply-To: <20060712095933.57d2a595.pauldrynoff@gmail.com>
References: <20060712095933.57d2a595.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 09:59:33 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> I try boot 2.6.18-rc1-mm1,
> here is result:
> 
> show_stack_log_lve
> show_registers
> die
> do_trap
> do_invalid_op
> error_code
> buffered_rmqueue
> get_page_from_freelist
> __alloc_pages
> get_zeroed_page
> sysenter_setup
> identify_cpu
> check_bugs
> start_kernel
> 
> EIP:... prep_new_page

Don't know, sorry.  Your config works ok here (well, gets a lot further).

It's dying quite late in boot there - the page allocator has already been
used a bit, but then it falls over in a heap.

I notice you're set up for an i386.  Is the target CPU really an i386?  If
not, and if you change this, does it affect anything?
