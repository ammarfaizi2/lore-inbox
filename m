Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVAEB3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVAEB3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAEB33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:29:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51178 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262157AbVAEB3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:29:02 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <1104878646.17166.63.camel@localhost.localdomain>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>  <87u0pxhvn0.fsf@sulphur.joq.us>
	 <1104865198.8346.8.camel@krustophenia.net>
	 <1104878646.17166.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 20:28:57 -0500
Message-Id: <1104888538.18410.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 00:01 +0000, Alan Cox wrote:
> The problem with uid/gid based hacks is that they get really ugly to
> administer really fast. Especially once you have users who need realtime
> and hugetlb, and users who need one only.
> 

Sorry, how does hugetlb relate to this?

> It would be far cleaner to split CAP_SYS_NICE capability down - which
> should cover the real time OS functions nicely. Right now it gives a few
> too many rights but that could be fixed easily.
> 

We need selected nonroot users to be able to run SCHED_FIFO tasks and
mlock().  It has to be easy to administer.  That's it.

As Jack mentioned, the developers of this patch are not kernel hackers
by trade, they wrote this to solve a real problem.  In other words, a
patch is worth a thousand words.

It seems distro vendors would be interested in solving this problem.
The linux audio market is smaller than the general desktop of course but
many of the users are professionals who would gladly pay for support.
Look how many people pay for OSX.  Wouldn't Red Hat and SuSE like some
of those customers?

Lee

