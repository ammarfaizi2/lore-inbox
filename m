Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUJVWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUJVWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUJVV5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:57:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268157AbUJVVzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:55:11 -0400
Date: Fri, 22 Oct 2004 14:55:03 -0700
Message-Id: <200410222155.i9MLt3Mf005325@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Laurent Dufour <ldufour@meiosys.com>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : Thread signal informations are not freed when it is
	execing.
In-Reply-To: Laurent Dufour's message of  Friday, 22 October 2004 16:52:34 +0200 <1098456754.6173.46.camel@soho.lab.meiosys.com>
Emacs: don't try this at home, kids!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't find the post you're talking about, but after reading 2.6.9
> de_thread function, I didn't find major diff with previous release. 

Like I said, the relevant fix is in *after* 2.6.9, in the current sources
you can get now from bk/bkcvs or snapshots.

> I wrote a new test case that works with 2.6.x kernel. I have run it on a
> Fedora Core 2 node with a 2.6.8-1.521 kernel and also with the new 2.6.9
> kernel, and it has also produce a leak in siqueue buffers. It can be
> seen by looking at sigqueue cache info in /proc/slabinfo.

Thanks.  I have verified that your test case produces the leak without my
patch, and has no leak with my patch.  The patch is in current sources but
not 2.6.9, and you can find it here:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/exec-fix-posix-timers-leak-and-pending-signal-loss.patch


Thanks,
Roland
