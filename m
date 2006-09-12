Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWILBEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWILBEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 21:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWILBEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 21:04:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965227AbWILBEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 21:04:08 -0400
Date: Mon, 11 Sep 2006 18:03:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-audit@redhat.com
Subject: Re: [git pull] audit updates and fixes
Message-Id: <20060911180346.c4bfd211.akpm@osdl.org>
In-Reply-To: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk>
References: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 18:37:49 +0100
Al Viro <viro@ftp.linux.org.uk> wrote:

> Audit fixes and missing bits; compared to the last attempt there are two added
> fixes from Amy...  Please, pull:
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git/ audit.b28

This seems a bit.... late.

The patch adds a whole bunch of new extern-decls-in-C.  It'd be nice to get
those into a header file sometime.

And sparc64 allmodconfig broke.

kernel/built-in.o(.text+0x36834): In function `audit_filter_rules':
: undefined reference to `audit_classify_syscall'
make: *** [.tmp_vmlinux1] Error 1

Possibly because the audit git tree fell out of -mm ages ago, partly
because its owner (ahem) ignored my request to resync it with upstream.  I
have new scripts from Junio and shall try again.

