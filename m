Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWJGPOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWJGPOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWJGPOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:14:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26496 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932120AbWJGPOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:14:47 -0400
Date: Sat, 7 Oct 2006 16:14:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minimal alpha pt_regs fixes
Message-ID: <20061007151443.GD29920@ftp.linux.org.uk>
References: <20061007131731.GC29920@ftp.linux.org.uk> <4527C2F7.2010102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4527C2F7.2010102@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 11:08:39AM -0400, Jeff Garzik wrote:
> Al Viro wrote:
> >diff --git a/include/asm-alpha/irq_regs.h b/include/asm-alpha/irq_regs.h
> >new file mode 100644
> >index 0000000..3dd9c0b
> >--- /dev/null
> >+++ b/include/asm-alpha/irq_regs.h
> >@@ -0,0 +1 @@
> >+#include <asm-generic/irq_regs.h>
> 
> 
> ACK, of course, but I wonder if we can do something about these 1-line 
> header files.
> 
> Would it be reasonable to encourage developers to do something like
> 
> 	#ifdef ARCH_HAVE_FEATURE_FOO
> 	#include <asm/foo.h>
> 	#else
> 	#include <asm-generic/foo.h>
> 	#endif

In something like linux/irq_regs.h?  Might make sense...
