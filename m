Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWJGS1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWJGS1P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWJGS1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:27:15 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:44995 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751565AbWJGS1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:27:14 -0400
Date: Sat, 7 Oct 2006 20:27:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minimal alpha pt_regs fixes
Message-ID: <20061007182708.GB5937@uranus.ravnborg.org>
References: <20061007131731.GC29920@ftp.linux.org.uk> <4527C2F7.2010102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4527C2F7.2010102@garzik.org>
User-Agent: Mutt/1.4.2.1i
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

It would be even more simple and future proof if we could in
some way do it so "#include <foo/bar.h>" would pick up bar.h from
asm-$(ARCH) if it exists and otherwise pick up asm-generic/bar.h.

Then we could include the generic one in asm-generic and
all architectures would include it except those that provide their
own variant. The asm-$(ARCH) specific files would need a way to include
the asm-generic version.

I have no idea handy for how to actually implment this but wanted
just to share the idea.
The trade-off is that if it gets too iplicit then suddenly users will
loose overview of how it works.

	Sam
