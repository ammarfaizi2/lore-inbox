Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWJGPIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWJGPIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWJGPIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:08:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37057 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932209AbWJGPIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:08:45 -0400
Message-ID: <4527C2F7.2010102@garzik.org>
Date: Sat, 07 Oct 2006 11:08:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minimal alpha pt_regs fixes
References: <20061007131731.GC29920@ftp.linux.org.uk>
In-Reply-To: <20061007131731.GC29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> diff --git a/include/asm-alpha/irq_regs.h b/include/asm-alpha/irq_regs.h
> new file mode 100644
> index 0000000..3dd9c0b
> --- /dev/null
> +++ b/include/asm-alpha/irq_regs.h
> @@ -0,0 +1 @@
> +#include <asm-generic/irq_regs.h>


ACK, of course, but I wonder if we can do something about these 1-line 
header files.

Would it be reasonable to encourage developers to do something like

	#ifdef ARCH_HAVE_FEATURE_FOO
	#include <asm/foo.h>
	#else
	#include <asm-generic/foo.h>
	#endif

to avoid these 1-line headers?

	Jeff


