Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUFZXLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUFZXLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUFZXLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:11:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:23739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267230AbUFZXJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:09:55 -0400
Date: Sat, 26 Jun 2004 16:08:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       trivial@rustcorp.com.au
Subject: Re: swsusp: kill useless exports
Message-Id: <20040626160857.343e9cb3.akpm@osdl.org>
In-Reply-To: <20040625115642.GA2307@elf.ucw.cz>
References: <20040625115642.GA2307@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> These exports seem totally unneccessary as swsusp can't be module
> anyway. Idea by Patrick Mochel. Please apply,
> 							Pavel
> 
> --- linux-cvs//arch/i386/power/cpu.c	2004-06-25 13:08:23.000000000 +0200
> +++ linux/arch/i386/power/cpu.c	2004-06-24 23:37:00.000000000 +0200
> @@ -147,7 +147,3 @@
>  {
>  	__restore_processor_state(&saved_context);
>  }
> -
> -
> -EXPORT_SYMBOL(save_processor_state);
> -EXPORT_SYMBOL(restore_processor_state);

These are called from apm.c, which can be built as a module.

(grep!)
