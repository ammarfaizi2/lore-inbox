Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268476AbUHaNWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbUHaNWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268472AbUHaNWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:22:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:49679 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268473AbUHaNTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:19:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
References: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
	<Pine.LNX.4.58.0408302119110.2295@ppc970.osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Aug 2004 22:19:04 +0900
In-Reply-To: <Pine.LNX.4.58.0408302119110.2295@ppc970.osdl.org>
Message-ID: <87k6vfqwc7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, I definitely agree with the approach

I agree with that approach.

> Looks pretty clean as an implementation. The question is whether we should 
> aim for 2.6.9 or 2.6.10 - if the first, then I should probably take it 
> now, otherwise it should go into -mm first and be merged early after 2.6.9 
> has been released, for the first -rc.
> 
> I _looks_ pretty safe, and it's hopefully much less likely to have subtle
> bugs and races than our old approach had, but I have a hard time judging. 

Ptrace has several ugly things. And I'm thinking those needs
user-visible change more or less to improve, like this.
(->parent/wait4/child_list, PTRACE_SYSCALL/PTRACE_SINGLESTEP ...)

Should we also clean up and improve those with user-visible change?
Those should be thought as separate issue?

I think we should be improved with new interface... (after it, we
can deprecate ptrace)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
