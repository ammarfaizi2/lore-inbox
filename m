Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUHYVPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUHYVPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268713AbUHYUy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:54:28 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:47118 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268709AbUHYUxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:53:43 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
References: <200408252020.i7PKKJSU017557@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 26 Aug 2004 05:53:19 +0900
In-Reply-To: <200408252020.i7PKKJSU017557@magilla.sf.frob.com>
Message-ID: <87llg3kkhs.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> > We should split TASK_STOPPED into two different cases: TASK_STOPPED and 
> > TASK_PTRACED.
> 
> Ok.  I think this has exactly the same effect as my patches get by
> introducing checks and invariants relating to last_siginfo.  To me that was
> less ambitious than introducing a new value for the state field, because I
> am not entirely sure I grok how that is used everywhere.  If you think that
> adding a new TASK_TRACED state will not have lots of gotchas, I am happy to
> take a crack at it.

I like it too. On my experimentation/check, adding new state was no big problem.

One things - SIGKILL wakes it up or not....

    wakeup     - still need the some lock
    not wakeup - user visible

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
