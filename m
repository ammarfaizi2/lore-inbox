Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268429AbUHYTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268429AbUHYTvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHYTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:50:41 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:15113 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268429AbUHYTsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:48:42 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
References: <200408251808.i7PI8jFF017075@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 26 Aug 2004 04:48:25 +0900
In-Reply-To: <200408251808.i7PI8jFF017075@magilla.sf.frob.com>
Message-ID: <87y8k3knhy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> > ptrace() is frangible, and racy. And looks like few things can't improve
> > without user visible change. So, I'm thinking I would like to rewrite
> > it by another interface.
> 
> I don't think such vague statements are useful.  Are there other races you
> are implicitly referring to here, or only the ones I have just cited?
> These issues are with the implementation, not the interface.  Changing the
> ptrace interface won't do anything about them, and fixing them need not
> change the ptrace interface.
> 
> The ptrace interface could use replacing, but that is really a separate
> issue.  I will be first in line to replace it with something that has saner
> semantics and a more convenient user interface.  But that won't help a whit
> with things like these race concerns.  Let's keep the issue of an ugly
> interface separate from the issue of potential bugs in the one we have.  If
> there are bugs (aside from the inherent limitations of the intended
> semantics), they need to be fixed.

Sorry for about it. Yes, racy is implementation issue. And AFAIK, it
seems to be fixed by we don't allow SIGCONT. (If it doesn't break userland)

> > And looks like few things can't improve without user visible
> > change. So, I'm thinking I would like to rewrite it by another
> > interface.

This is reason that I wouldn't like that we continue to be expanding
ptrace().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
