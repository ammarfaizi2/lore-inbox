Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWBMLr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWBMLr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWBMLr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:47:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49324 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751195AbWBMLr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:47:58 -0500
Date: Mon, 13 Feb 2006 12:46:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-ID: <20060213114612.GA30500@elte.hu>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home> <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131235180.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Mon, 13 Feb 2006, Thomas Gleixner wrote:
> 
> > > A const for arguments which are passed by value is completely ignored by
> > > gcc. It has only an effect on local variables and even here gcc doesn't
> > > need it either to produce better code.
> > 
> > NACK - gcc3 produces smaller code with the const - only gcc4 fixed that
> 
> That would would be a compiler problem, these const _are_ bogus.

code size is really important for the ktime ops, so i'd keep the consts 
for the time being. In any case, it's definitely not a 2.6.16 change.

> [...] and this patch doesn't break anything either.

your patch makes code larger on gcc3. Please investigate why.

	Ingo
