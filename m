Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUIOUnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUIOUnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIOUl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:41:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8837 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267410AbUIOUjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:39:42 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@novell.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040915200018.GA17773@elte.hu>
References: <20040913061641.GA11276@elte.hu> <41489B7A.6010407@tmr.com>
	 <20040915200018.GA17773@elte.hu>
Content-Type: text/plain
Message-Id: <1095280788.2406.171.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 16:39:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 16:00, Ingo Molnar wrote:
> * Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > Okay, I'll be the one to ask... what overload of the IPL acronym are
> > you using here? I asked google and several jargon files, and they all
> > say that IPL (initial program load) is IBMspeak for cold boot. Somehow
> > I don't think that's what you mean here.
> 
> i understood it as Interrupt Privilege Levels. The notion of having some
> sort of scalar 'limit' - all interrupts with a higher priority than that
> will execute, all interrupts with lower priority will block.  This is a
> fundamentally dodgy concept because in reality interrupt sources are
> independent entities so the natural description for of them is a bitmask
> (or an array, or whatever), not a level.
> 

Yeah, I was talking about interrupt priority levels.  I have to admit my
only exposure to them is a book on Solaris, they are intended as a
mechanism to deal with priority inversions.  Sounds like a neat trick on
paper but they don't seem to be applicable here.

Lee

