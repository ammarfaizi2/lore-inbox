Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbTIJP3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTIJP3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:29:39 -0400
Received: from gprs145-173.eurotel.cz ([160.218.145.173]:49281 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265000AbTIJP3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:29:31 -0400
Date: Wed, 10 Sep 2003 17:29:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910152902.GA2764@elf.ucw.cz>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910142308.GL932@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > none of this patch seems to touch particularly performance critical code.
>  > > Is it really worth adding these macros to every if statement in the kernel?
>  > > There comes a point where readability is lost, for no measurable gain.
>  > 
>  > Perhaps we should have macros ifu() and ifl(), that would be used as a
>  > plain if, just with likelyness-indication? That way we could have it
>  > in *every* statement and readability would not suffer that much...
> 
> You've got to be kidding.

I'm pretty serious.

	ifu (a==b) {
		something();
	}

looks better than 

	if (unlikely(a==b)) {
		something();
	}

sched.c alone probably would get more readable as a result of such
conversion...

[Okay, having it at every statement is prbably bad idea.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
