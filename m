Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUHYVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUHYVPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUHYVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:10:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:36795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268752AbUHYVDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:03:00 -0400
Date: Wed, 25 Aug 2004 14:02:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: <87llg3kkhs.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.58.0408251400530.17766@ppc970.osdl.org>
References: <200408252020.i7PKKJSU017557@magilla.sf.frob.com>
 <87llg3kkhs.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, OGAWA Hirofumi wrote:
> 
> One things - SIGKILL wakes it up or not....

Nope.

SIGKILL _already_ doesn't actually wake up a ptraced task. It just informs 
the tracer, last I looked.

So a new state should be pretty simple, and I really think it would be the
right way to go. That said, I might just be completely wrong - maybe there
are practical problems to that approach that I don't see right now.

		Linus
