Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWGNRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWGNRmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWGNRmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:42:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422660AbWGNRmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:42:13 -0400
Date: Fri, 14 Jul 2006 10:41:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
In-Reply-To: <1152898699.27135.20.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>  <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
 <1152898699.27135.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Steven Rostedt wrote:
> 
> > 	endflag = 1;
> > 	smp_wmb();
> 
> This was what I originally wrote, and then I saw the set_wmb which made
> me think that it was the proper way to do things (why else is it
> there?). So if it shouldn't be used, then we should get rid of it or at
> least mark it deprecated, otherwise you have people like me thinking
> that we should use it.

Yeah, we should probably get rid of it. No need to even mark it 
deprecated, since nobody uses it anyway. 

At a minimum, I think we should not document it in the locking 
documentation, making people incorrectly think it might be a good idea.

Hmm? Andrew?

		Linus
