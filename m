Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVAGUqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVAGUqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVAGUqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:46:07 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14489 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261594AbVAGUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:45:34 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Matt Mackall <mpm@selenic.com>
Cc: "Jack O'Quin" <joq@io.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreas Steinmetz <ast@domdv.de>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
In-Reply-To: <20050107200245.GW2940@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>
	 <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de>
	 <1104898693.24187.162.camel@localhost.localdomain>
	 <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us>
	 <20050107200245.GW2940@waste.org>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 15:45:26 -0500
Message-Id: <1105130727.20278.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 12:02 -0800, Matt Mackall wrote:
> The trouble with introducing something into the kernel is that once
> done, it can't be undone. So you're absolutely going to meet
> resistance to anything that can be a) done sufficiently in userspace
> or b) can reasonably be done in a more generic manner so as to meet
> the needs of a wider future audience. The onus is on the submitter to
> meet these requirements because we can't easily kick out a broken API
> after we accept it.

For a big subsystem that exposes an API, you would be right.  But this
is a *really* simple problem, all you need is a way to tell it who gets
RT privileges, which means uid or gid.  So any future solution will be
orthogonal to this one, and when users upgrade even a not very smart
Perl script will be able to migrate the configuration.  How many
different ways are there to say "these are the non-root users who have
realtime prvileges", anyway?

Unless, of course, the solution that's eventually merged is *really*
overcomplicated by comparison, in which case users will (rightly) reject
it, and the system will have worked.

Lee 



