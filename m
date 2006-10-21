Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWJWMb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWJWMb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWJWMb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:31:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751937AbWJWMbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:31:37 -0400
Date: Sat, 21 Oct 2006 14:42:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
Subject: Re: [linux-pm] [PATCH] Add include/linux/freezer.h and move definitions from	sched.h
Message-ID: <20061021124225.GA10892@elf.ucw.cz>
References: <1161433266.7644.7.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161433266.7644.7.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move process freezing functions from include/linux/sched.h to freezer.h,
> so that modifications to the freezer or the kernel configuration don't
> require recompiling just about everything.

Well, I'm not sure if freezer changes often enough for this to
matter. ..

Patch is pretty much okay (provided it does not change any code)
"is it worth the change" is up-to Andrew.

> --- /dev/null
> +++ b/include/linux/freezer.h
> @@ -0,0 +1,84 @@
> +/* Freezer declarations */
> +

Needs copyright/GPL at least.

> +#ifdef CONFIG_PM
> +/*
> + * Check if a process has been frozen
> + */
> +static inline int frozen(struct task_struct *p)
> +{
> +	return p->flags & PF_FROZEN;
> +}

And switch it to kerneldoc while you are at it...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
