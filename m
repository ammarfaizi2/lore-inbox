Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVAGVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVAGVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVAGVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:21:38 -0500
Received: from waste.org ([216.27.176.166]:57820 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261598AbVAGVUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:20:42 -0500
Date: Fri, 7 Jan 2005 13:20:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreas Steinmetz <ast@domdv.de>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107212018.GZ2940@waste.org>
References: <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us> <20050107200245.GW2940@waste.org> <87mzvl56j5.fsf@sulphur.joq.us> <20050107204650.GY2940@waste.org> <1105131313.20278.81.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105131313.20278.81.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 03:55:12PM -0500, Lee Revell wrote:
> On Fri, 2005-01-07 at 12:46 -0800, Matt Mackall wrote:
> > You just map your RT-dependent routine (PIC, of course) into the
> > segment and move your stack pointer into a second segment. I didn't
> > say it was easy, but it's all just bits. There's also the rlimit
> > issue.
> > 
> > Or, going the other way, the client app can pass map handles to the
> > server to bless. Some juggling might be involved but it's obviously
> > doable.
> > 
> 
> Christ, what a nightmare!  Since when does "obviously doable" mean it's
> a good idea?  Please, reread your above statements, then go back and
> look at the realtime LSM patch (it's less than 200 lines), and tell me
> again that your way is more secure.

My way simply proves that existing userspace methods have not been
exhausted. It's not impossible as was claimed and cleaner methods or
nicely wrapped variants of the above probably exist. And yes, doing
ugly things in userspace is preferable to adding application-specific
baggage to the kernel.

> > As has been pointed out, an rlimit solution exists now as well.
> 
> Wrong, as was said repeatedly, rlimits only help with mlock!  Have you
> even been reading the thread?

Feh. The RT scheduling class issue is orthogonal. Addressing mlock and
scheduling class at once (and nothing else) is actually an ugliness of
your LSM approach as there are folks who want mlock and not RT.

-- 
Mathematics is the supreme nostalgia of our time.
