Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTE0R5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTE0R4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:56:41 -0400
Received: from web41501.mail.yahoo.com ([66.218.93.84]:15269 "HELO
	web41501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264050AbTE0Rwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:52:33 -0400
Message-ID: <20030527180546.15656.qmail@web41501.mail.yahoo.com>
Date: Tue, 27 May 2003 11:05:46 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: inventing the wheel?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was interested in finding a tool that would tell me all the paths
through the kernel leading to some particular function, for example in
the case of do_mmap_pgoff:

do_mmap_pgoff do_mmap2 old_mmap old_mmap_i386
do_mmap_pgoff do_mmap2 sys_mmap2
do_mmap_pgoff do_mmap aio_setup_ring ioctx_alloc sys_io_setup
do_mmap_pgoff do_mmap elf_map load_elf_binary
...

I submitted a tool ('fscope') to do this but no one has picked up
on the discussion. So I am wondering if there isn't already some
existing and better way to accomplish the same thing.

Could somebody tell me please, what is that way?

I know you can do a backtrace w/ gdb but that begs the question
how are you going to sure you have found every path?
