Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUF2Woz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUF2Woz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUF2Woz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:44:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:25066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266128AbUF2Woy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:44:54 -0400
Date: Tue, 29 Jun 2004 15:44:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] building linux-2.4 with gcc 3.3.3
Message-ID: <20040629154453.C1973@build.pdx.osdl.net>
References: <20040629153452.5a03ab5e@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040629153452.5a03ab5e@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Tue, Jun 29, 2004 at 03:34:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Hemminger (shemminger@osdl.org) wrote:
> diff -Nru a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
> --- a/arch/i386/kernel/signal.c	2004-06-29 15:31:58 -07:00
> +++ b/arch/i386/kernel/signal.c	2004-06-29 15:31:58 -07:00
> @@ -581,7 +581,7 @@
>   * want to handle. Thus you cannot kill init even with a SIGKILL even by
>   * mistake.
>   */
> -int do_signal(struct pt_regs *regs, sigset_t *oldset)
> +fastcall int do_signal(struct pt_regs *regs, sigset_t *oldset)

might be nice to keep this change inline with 2.6 which has different
order:
  int fastcall do_signal

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
