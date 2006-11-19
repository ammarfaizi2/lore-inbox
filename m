Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756502AbWKSI3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbWKSI3m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbWKSI3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 03:29:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7386 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756502AbWKSI3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 03:29:41 -0500
Date: Sun, 19 Nov 2006 09:29:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061119082921.GA21468@elf.ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611190320_MC3-1-D21B-111C@compuserve.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When doing 'make oldconfig' we should ask about suspend/resume
> debug features when SOFTWARE_SUSPEND is not enabled.

These are suspend-to-ram debugging features, mostly, so no, they
should not depend on software suspend.

NAK. 

> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.19-rc6-32.orig/kernel/power/Kconfig
> +++ 2.6.19-rc6-32/kernel/power/Kconfig
> @@ -38,7 +38,7 @@ config PM_DEBUG
>  
>  config DISABLE_CONSOLE_SUSPEND
>  	bool "Keep console(s) enabled during suspend/resume (DANGEROUS)"
> -	depends on PM && PM_DEBUG
> +	depends on PM_DEBUG && SOFTWARE_SUSPEND
>  	default n
>  	---help---
>  	This option turns off the console suspend mechanism that prevents
> @@ -49,7 +49,7 @@ config DISABLE_CONSOLE_SUSPEND
>  
>  config PM_TRACE
>  	bool "Suspend/resume event tracing"
> -	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
> +	depends on PM_DEBUG && SOFTWARE_SUSPEND && X86_32 && EXPERIMENTAL
>  	default n
>  	---help---
>  	This enables some cheesy code to save the last PM event point in the

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
