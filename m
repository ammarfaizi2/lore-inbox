Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUJYS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUJYS5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJYS4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:56:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261244AbUJYSzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:55:02 -0400
Date: Mon, 25 Oct 2004 11:54:53 -0700
Message-Id: <200410251854.i9PIsrjX010407@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: BUG_ONs in signal.c?
In-Reply-To: Jesse Barnes's message of  Monday, 25 October 2004 09:23:54 -0700 <200410250923.54067.jbarnes@engr.sgi.com>
X-Windows: complex nonsolutions to simple nonproblems.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, this looks good, although we'll end up calling do_group_exit
> instead of do_exit for the dumped task, is that ok?

It's necessary for correcetness.  do_group_exit takes the siglock and
checks the group_exit and group_exit_code fields, so in the race situation
the thread gets the right exit code.


Thanks,
Roland
