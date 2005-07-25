Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVGYVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVGYVq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVGYVq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:46:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbVGYVq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:46:56 -0400
Date: Mon, 25 Jul 2005 14:45:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12 and 2.6.13 hangs for a while on boot
Message-Id: <20050725144558.03c0347c.akpm@osdl.org>
In-Reply-To: <20050719180521.8914.qmail@web60711.mail.yahoo.com>
References: <20050719180521.8914.qmail@web60711.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
>
> I'm having little hangs while booting with kernels 2.6.12 and 2.6.13-rc1, rc2
>  and rc3.
> 
>  It is strange that 2.6.12-rc1 booted ok without hangs.
> 
>  I saw a post of Alan Cox on rc-1 release notes:
> 
>  "Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
>      0x1e8, 0x168, 0x1e0 or 0x160.  Linux thus probes these addresses on x86
>      systems.  Unfortunately some PCI systems now use these addresses for other
>      purposes which leads to users seeing minute plus hangs during boot or even
>      crashes."
> 
>  I thought this could be my problem, but it still hangs on boot.
> 
>  Hangs appears just before mounting filesystems message and before configuring
>  system to use udev.

Are these hangs temporary or permanent?  If they are temporary (ie: the
kernel recovers OK) then we should call them "stalls".  Because a "hang" is
considered to be a permanent state.

Either way, we need to know where the kernel is stuck.  Adding
`initcall_debug' to your kernel boot command may help.

And when the hang/stall occurs, hit the ALT-SSQRQ-P and ALT-SYSRQ-T key
combinations and send us the resulting traces.

Thanks.
