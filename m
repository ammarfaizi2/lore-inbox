Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVANEEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVANEEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVANEEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:04:43 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:46224 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261885AbVANEEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:04:38 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Andrew Morton <akpm@osdl.org>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <41E73E98.8070603@kolivas.org>
References: <200501140330.j0E3UCiG027037@localhost.localdomain>
	 <41E73E98.8070603@kolivas.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:04:11 +1100
Message-Id: <1105675451.5402.73.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 14:38 +1100, Con Kolivas wrote:
> Paul Davis wrote:

> > its a fine answer, but its the answer to a slightly different
> > question. if anyone (maybe us audio freaks, maybe someone else) comes
> > up with a reason to want "The Real SCHED_FIFO", the original question
> > will have gone unanswered.
> 
> Ah then  you missed something. You can set the max cpu of SCHED_ISO to 
> 100% and then you have it.
> 

Is that a good solution? I'm not sure if it is wise to try to
masquerade SCHED_ISO as an unprivileged RT class.

I mean what happens if two users are trying to run independent
SCHED_ISO systems? Both will probably break, right?

And how can you provide _any_ guarantees in an arbitrary environment
without this becoming a privileged operation? I can't quite get my head
around that at the moment...

I guess if you have SCHED_ISO start out with 0 guarantees, and have root
dole some out, then it may be workable. But then that is just another
specialised ad hoc sort of hack wouldn't it? (not talking about
SCHED_ISO itself, but the granting of the privilege to use it).




