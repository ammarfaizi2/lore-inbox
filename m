Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVAGUYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVAGUYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVAGUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:22:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:10182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261600AbVAGUV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:21:26 -0500
Date: Fri, 7 Jan 2005 12:21:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: "Jack O'Quin" <joq@io.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreas Steinmetz <ast@domdv.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107122117.G2357@build.pdx.osdl.net>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us> <20050107200245.GW2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107200245.GW2940@waste.org>; from mpm@selenic.com on Fri, Jan 07, 2005 at 12:02:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Thu, Jan 06, 2005 at 11:54:05PM -0600, Jack O'Quin wrote:
> > Note that sched_setschedule() provides no way to handle the mlock()
> > requirement, which cannot be done from another process.
> 
> I'm pretty sure that part can be done by a privileged server handing
> out mlocked shared memory segments.

It can actually be done with plain ol' rlimits (RLIMIT_MEMLOCK).

> The trouble with introducing something into the kernel is that once
> done, it can't be undone. So you're absolutely going to meet
> resistance to anything that can be a) done sufficiently in userspace
> or b) can reasonably be done in a more generic manner so as to meet
> the needs of a wider future audience. The onus is on the submitter to
> meet these requirements because we can't easily kick out a broken API
> after we accept it.

Indeed (although in this case it's not adding an API as much as using an
existing one).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
