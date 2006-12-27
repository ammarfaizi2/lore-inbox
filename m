Return-Path: <linux-kernel-owner+w=401wt.eu-S964986AbWL1IiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWL1IiN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWL1IiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:38:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3794 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964988AbWL1IiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:12 -0500
Date: Wed, 27 Dec 2006 17:10:11 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
Message-ID: <20061227171010.GA4088@ucw.cz>
References: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221234127.29189.qmail@web55606.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Was just wondering if the _var_ in kfree(_var_) could be set to NULL after its freed. It may solve
> the problem of accessing some freed memory as the kernel will crash since _var_ was set to NULL.
> 
> Does this make sense? If yes, then how about renaming kfree to something else and providing a
> kfree macro that would do the following:
> 
> #define kfree(x) do { \
>                       new_kfree(x); \
>                       x = NULL; \
>                     } while(0)
> 
> There might be other better ways too.

No, that would be very confusing. Otoh having

KFREE() do kfree() and assignment might be acceptable.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
