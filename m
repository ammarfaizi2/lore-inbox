Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVHAWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVHAWTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVHAWRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:17:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22996 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261171AbVHAWPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:15:48 -0400
Date: Tue, 2 Aug 2005 00:14:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-ID: <20050801221432.GA1413@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz> <20050727023754.6846f3a2.akpm@osdl.org> <20050727095324.GE4270@elf.ucw.cz> <1122458769.7773.39.camel@localhost.localdomain> <3059.24.240.41.150.1122931398.squirrel@69.129.69.193>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3059.24.240.41.150.1122931398.squirrel@69.129.69.193>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> +	/* read comadj */
> >> +#ifdef CONFIG_MACH_POODLE
> >> +	comadj = 118;
> >> +#else
> >> +	comadj = 128;
> >> +#endif
> >
> > Can you go back to the Sharp source and confirm that these values should
> > be hardcoded in both the poodle and collie cases please? I know the
> > sharpsl_param code can provide them but I can't remember exactly which
> > models use which fields. I want to make sure this isn't a quick hack
> > John made before sharpsl_param was written :).
> 
> No, those values were from the original sharp code...  at some point I was
> going to investigate what values the sharpsl param stuff returned and see
> if those worked.  If the sharpsl stuff works, then by all means use it.

I added code to read it from sharpsl, if it is not there, I use
defaults above. It seems to work on my collie.
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
