Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVAGU44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVAGU44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVAGU4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:56:10 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:8090 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261600AbVAGUzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:55:37 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: "Jack O'Quin" <joq@io.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreas Steinmetz <ast@domdv.de>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
In-Reply-To: <20050107204650.GY2940@waste.org>
References: <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
	 <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	 <1104898693.24187.162.camel@localhost.localdomain>
	 <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us>
	 <20050107200245.GW2940@waste.org> <87mzvl56j5.fsf@sulphur.joq.us>
	 <20050107204650.GY2940@waste.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 15:55:12 -0500
Message-Id: <1105131313.20278.81.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 12:46 -0800, Matt Mackall wrote:
> You just map your RT-dependent routine (PIC, of course) into the
> segment and move your stack pointer into a second segment. I didn't
> say it was easy, but it's all just bits. There's also the rlimit
> issue.
> 
> Or, going the other way, the client app can pass map handles to the
> server to bless. Some juggling might be involved but it's obviously
> doable.
> 

Christ, what a nightmare!  Since when does "obviously doable" mean it's
a good idea?  Please, reread your above statements, then go back and
look at the realtime LSM patch (it's less than 200 lines), and tell me
again that your way is more secure.

Please keep in mind that there are already 1000s of users using the
realtime LSM to do audio work.  Sorry, but I will take a known good,
well understood, PROVEN solution over "it's obviously doable, it's all
bits anyway".  Get back to me when you have some code, or at least some
reasonable suggestions as Alan, Christoph and others have made.

> As has been pointed out, an rlimit solution exists now as well.

Wrong, as was said repeatedly, rlimits only help with mlock!  Have you
even been reading the thread?

Lee

