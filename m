Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUHaEuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUHaEuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHaEuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:50:44 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:12687 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S266569AbUHaEub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:50:31 -0400
Date: Mon, 30 Aug 2004 21:50:28 -0700
Message-Id: <200408310450.i7V4oSoS001901@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Linus Torvalds's message of  Monday, 30 August 2004 21:27:54 -0700 <Pine.LNX.4.58.0408302119110.2295@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Windows: ignorance is our most important resource.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I _looks_ pretty safe, and it's hopefully much less likely to have subtle
> bugs and races than our old approach had, but I have a hard time judging. 
> I assume you ran all your gdb tests on the result? What's your gut feel?

My gut feel is that it's pretty safe.  I did run all the LTP ptrace
programs, and the gdb test suite.  (The gdb test suite has failures because
of gdb's own issues and perhaps the state of my gdb build, so I can't be
totally certain that it has zero new complaints, but I am pretty sure it
didn't change the results.)


Thanks,
Roland
