Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269655AbUJMIPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbUJMIPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUJMIPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:15:50 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:20138 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S269655AbUJMIPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:15:46 -0400
Message-ID: <416CE442.7020909@sdl.hitachi.co.jp>
Date: Wed, 13 Oct 2004 17:16:02 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Wen-chien Jesse Sung <jesse@opnet.com.tw>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org> <1097653366.6209.15.camel@libra>
In-Reply-To: <1097653366.6209.15.camel@libra>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen-chien Jesse Sung wrote:

> kernel/sysctl.c does not compile if CONFIG_SWAP=n.
> 
> --- 2.6.9-rc4-mm1/kernel/sysctl.c  (revision 16)
> +++ 2.6.9-rc4-mm1/kernel/sysctl.c  (local)
> @@ -813,6 +813,7 @@
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dointvec,
>  	},
> +#ifdef CONFIG_SWAP
>  	{
>  		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
>  		.procname	= "swap_token_timeout",
> @@ -822,6 +823,7 @@
>  		.proc_handler	= &proc_dointvec_jiffies,
>  		.strategy	= &sysctl_jiffies,
>  	},
> +#endif
>  	{ .ctl_name = 0 }
>  };

Hello, Wen-chien

Your fix is correct.

Thank you. 

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

