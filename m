Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWHSDl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWHSDl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWHSDl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 23:41:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53452 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751621AbWHSDl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 23:41:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill extraneous printk in kernel_restart()
References: <Pine.LNX.4.64.0608181650001.30597@lancer.cnet.absolutedigital.net>
Date: Fri, 18 Aug 2006 21:41:05 -0600
In-Reply-To: <Pine.LNX.4.64.0608181650001.30597@lancer.cnet.absolutedigital.net>
	(Cal Peake's message of "Fri, 18 Aug 2006 17:02:12 -0400 (EDT)")
Message-ID: <m13bbtwfxq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake <cp@absolutedigital.net> writes:

> Hi,
>
> Is there a reason for printing a single dot and newline in 
> kernel_restart()? If not, below is a one-liner to kill it.

Hmm.  This looks like a thinko from my original patch.

Signed-off-By: Eric W. Biederman <ebiederm@xmission.com>

> -- 
>
> Get rid of an extraneous printk in kernel_restart().
>
> Signed-off-by: Cal Peake <cp@absolutedigital.net>
>
> --- linux-2.6.18-rc4/kernel/sys.c~orig	2006-08-07 22:00:27.000000000 -0400
> +++ linux-2.6.18-rc4/kernel/sys.c	2006-08-18 16:52:52.000000000 -0400
> @@ -611,7 +611,6 @@ void kernel_restart(char *cmd)
>  	} else {
>  		printk(KERN_EMERG "Restarting system with command '%s'.\n", cmd);
>  	}
> -	printk(".\n");
>  	machine_restart(cmd);
>  }
>  EXPORT_SYMBOL_GPL(kernel_restart);
