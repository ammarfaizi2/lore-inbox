Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUBCU33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUBCU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:29:28 -0500
Received: from waste.org ([209.173.204.2]:61885 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266091AbUBCU31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:29:27 -0500
Date: Tue, 3 Feb 2004 14:29:16 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add syscalls.h
Message-ID: <20040203202916.GC31138@waste.org>
References: <20040130163547.2285457b.rddunlap@osdl.org> <20040201222254.39bc5b39.rddunlap@osdl.org> <20040201224344.43d1c37d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201224344.43d1c37d.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 10:43:44PM -0800, Andrew Morton wrote:
> +extern asmlinkage long sys_unlink(const char __user *pathname);
> +extern asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
> +extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
> 
> Maybe lose the `extern' too.  It's just a waste of space.  I normally put
> it in for consistency if the surrounding code is done that way, but for a
> new header file, why bother?

I'd really like to see the extern go, if only to discourage that
particular bit of cargo cult programming. There are actually people
who think it serves a purpose..

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
