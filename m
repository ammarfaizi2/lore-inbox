Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWFREzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWFREzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWFREzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:55:35 -0400
Received: from xenotime.net ([66.160.160.81]:31424 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932089AbWFREzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:55:35 -0400
Date: Sat, 17 Jun 2006 21:58:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sturmflut@lieberbiber.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding
 memory maps
Message-Id: <20060617215818.7bc728af.rdunlap@xenotime.net>
In-Reply-To: <200606171614.58610.sturmflut@lieberbiber.de>
References: <200606171614.58610.sturmflut@lieberbiber.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 16:14:52 +0200 Simon Raffeiner wrote:

> When compiling 2.6.17-rc6-mm2 (which contains this patch) my gcc 4.0.3 (Ubuntu 
> 4.0.3-1ubuntu5) complains about "int len;" being used uninitialized in 
> print_vma(). AFAICS len is not initialized and then passed to 
> pad_len_spaces(int len), which uses it for some calculations.
> 
> I also noticed that similar code is used in fs/proc/task_mmu.c, where 
> show_map_internal() passes an uninitialised int len; to pad_len_spaces(struct 
> seq_file *m, int len).

Ack both of those.  And both of them pass &len as a parameter to
printk/seq_printf where it looks as though they want just <len>
(after it has been initialized).

> Please include my E-Mail address in replies as I am not subscribed to LKML.

---
~Randy
