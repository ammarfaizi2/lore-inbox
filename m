Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269246AbUJKUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269246AbUJKUzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUJKUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:55:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269246AbUJKUzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:55:18 -0400
Date: Mon, 11 Oct 2004 13:55:05 -0700
Message-Id: <200410112055.i9BKt5LI031359@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
In-Reply-To: Joshua Kwan's message of  Sunday, 10 October 2004 14:15:07 -0700 <20041010211507.GB3316@triplehelix.org>
Emacs: if it payed rent for disk space, you'd be rich.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)

That is a clearly bogus argument.  (In fact it looks like a stack address,
a common thing to be found in uninitialized variables.)  Unless you have
some reason to suspect that this is not the argument actually passed by
make, then you should look at make and see why it passed the bogus
argument.  So far, I still don't see a direct suggestion of a kernel bug
here.  



Thanks,
Roland
