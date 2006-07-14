Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWGNRie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWGNRie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWGNRie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:38:34 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44766 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422678AbWGNRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:38:33 -0400
Subject: Re: [PATCH] remove volatile from nmi.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 13:38:19 -0400
Message-Id: <1152898699.27135.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 10:28 -0700, Linus Torvalds wrote:
> 

> 	endflag = 1;
> 	smp_wmb();
> 

This was what I originally wrote, and then I saw the set_wmb which made
me think that it was the proper way to do things (why else is it
there?). So if it shouldn't be used, then we should get rid of it or at
least mark it deprecated, otherwise you have people like me thinking
that we should use it.

-- Steve


