Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVAEBwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVAEBwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVAEBwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:52:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:57783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbVAEBur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:50:47 -0500
Date: Tue, 4 Jan 2005 17:50:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050104175043.H469@build.pdx.osdl.net>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us> <1104865198.8346.8.camel@krustophenia.net> <1104878646.17166.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1104878646.17166.63.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 05, 2005 at 12:01:55AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Maw, 2005-01-04 at 18:59, Lee Revell wrote:
> > We could do it the was OSX (our real competition) does if that would
> > make people happy.  They just let any user run RT tasks.  Oh wait, but
> > that's a "broken design", everyone knows that OSX is a joke, no one
> > would use *that* OS to mix a CD or score a movie.  :-)
> 
> You can do that already, just make everyone root
> 
> The problem with uid/gid based hacks is that they get really ugly to
> administer really fast. Especially once you have users who need realtime
> and hugetlb, and users who need one only.

I don't believe the hugetlb gid stuff is useful anymore.  It should be
handled nicely via rlimits.

> It would be far cleaner to split CAP_SYS_NICE capability down - which
> should cover the real time OS functions nicely. Right now it gives a few
> too many rights but that could be fixed easily.

Hmm, how do we do this w/out breaking things?  Maybe I'm misunderstanding
your idea.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
