Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUHSWHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUHSWHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUHSWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:07:13 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:20121 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S267452AbUHSWEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:04:42 -0400
Date: Thu, 19 Aug 2004 15:04:36 -0700
Message-Id: <200408192204.i7JM4aP7025390@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent cleanup
In-Reply-To: OGAWA Hirofumi's message of  Friday, 20 August 2004 07:01:58 +0900 <87y8kazt0p.fsf@devron.myhome.or.jp>
X-Windows: let it get in *your* way.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath <roland@redhat.com> writes:
> 
> > > Roland McGrath <roland@redhat.com> writes:
> > > > +	BUG_ON(tsk->state != TASK_STOPPED);
> > > 
> > > task->state is changed anytime, right?  Although the window is small,
> > > I think we should remove it at least for right now.
> 
> > I put it there intending just to ensure that all the code paths
> > were the stopping ones, as all the extant ones are.
> 
> Ah, I see.
> 
> Instead of BUG_ON(), how about WARN_ON() for debug? Since window is
> small...

It's small but certainly valid.  I think it's better to leave the assertion
out entirely for the moment, and just revamp this so that notify_parent as
such no longer exists.


Thanks,
Roland
