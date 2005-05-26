Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVEZXW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVEZXW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEZXW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:22:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261845AbVEZXW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:22:56 -0400
Date: Thu, 26 May 2005 16:22:49 -0700
Message-Id: <200505262322.j4QNMnd9011168@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, mtk-lkml@gmx.net,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
In-Reply-To: Linus Torvalds's message of  Thursday, 26 May 2005 16:19:02 -0700 <Pine.LNX.4.58.0505261617360.2307@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Zippy-Says: Don't SANFORIZE me!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> x86 has largely tried to move in that direction too, ie a lot of the 
> asm-calls have been turned into FASTCALL() with %eax pointing to the 
> stack.
> 
> Roland, I applied the patch, but if there was some particular case that 
> triggered this, maybe it's worth trying to re-write that one.

It's a danger for any system call.  Here it was sys_waitid.
