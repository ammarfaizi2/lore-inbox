Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUHYUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUHYUXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUHYUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:23:37 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:39300 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S268589AbUHYUUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:20:23 -0400
Date: Wed, 25 Aug 2004 13:20:19 -0700
Message-Id: <200408252020.i7PKKJSU017557@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: Linus Torvalds's message of  Wednesday, 25 August 2004 12:54:11 -0700 <Pine.LNX.4.58.0408251252080.17766@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Windows: putting new limits on productivity.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We should split TASK_STOPPED into two different cases: TASK_STOPPED and 
> TASK_PTRACED.

Ok.  I think this has exactly the same effect as my patches get by
introducing checks and invariants relating to last_siginfo.  To me that was
less ambitious than introducing a new value for the state field, because I
am not entirely sure I grok how that is used everywhere.  If you think that
adding a new TASK_TRACED state will not have lots of gotchas, I am happy to
take a crack at it.


Thanks,
Roland


