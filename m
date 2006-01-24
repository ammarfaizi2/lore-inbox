Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWAXVFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWAXVFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWAXVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:05:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8172 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750710AbWAXVFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:05:18 -0500
Date: Tue, 24 Jan 2006 22:05:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: joe.korty@ccur.com, Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124210548.GA22294@elte.hu>
References: <20060124180954.GA14506@tsunami.ccur.com> <20060124181712.GA13277@infradead.org> <20060124182942.GA16241@tsunami.ccur.com> <1138127523.2977.70.camel@laptopd505.fenrus.org> <20060124183808.GA16507@tsunami.ccur.com> <1138128156.2977.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138128156.2977.73.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > 2) The _raw versions are intended to be used in places where it is
> > known that preemption is already disabled, so that the overhead of
> > re-disabling/enabling it can be avoided.
> 
> that's not true either. If it was, then the name would have been 
> different.

indeed. The __raw versions are _not_ to be used by anything else but the 
generic spinlock code. (There's one other stray use by PARISC, but that 
is justified.)

[ the -rt tree makes use of 'raw_' spinlocks, but they are totally
  different things. ]

	Ingo
