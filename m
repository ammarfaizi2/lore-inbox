Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268749AbUHYVcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268749AbUHYVcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbUHYV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:27:48 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:11669 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S268786AbUHYVHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:07:36 -0400
Date: Wed, 25 Aug 2004 14:07:33 -0700
Message-Id: <200408252107.i7PL7XWw017681@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: Linus Torvalds's message of  Wednesday, 25 August 2004 14:02:47 -0700 <Pine.LNX.4.58.0408251400530.17766@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I wonder if I could ever get started in the credit world?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SIGKILL _already_ doesn't actually wake up a ptraced task. It just informs 
> the tracer, last I looked.

I think it's supposed to do so now, and actually fails to only sometimes in
practice and I don't know what the conditions are.  But, if you find it
acceptable that a traced task stay stopped in trace and not die from
SIGKILL until the tracer resumes it or detaches/dies, then aiming for that
certainly makes it easier to keep the ptrace code race-free.

> So a new state should be pretty simple, and I really think it would be the
> right way to go. That said, I might just be completely wrong - maybe there
> are practical problems to that approach that I don't see right now.

I'm going to try it out very soon and then we can see how the testing goes.


Thanks,
Roland
