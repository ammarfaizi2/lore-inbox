Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJWERq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJWERq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUJWERd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:17:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267469AbUJWEOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:14:47 -0400
Date: Fri, 22 Oct 2004 21:14:39 -0700
Message-Id: <200410230414.i9N4Edia027359@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: BUG_ONs in signal.c?
In-Reply-To: Andrew Morton's message of  Friday, 22 October 2004 20:47:51 -0700 <20041022204751.3f7a3b1f.akpm@osdl.org>
X-Windows: all the problems and twice the bugs.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once group_exit is set, it should never be cleared and group_exit_code
should never be changed.  It's set at the beginning of do_coredump.  If
do_coredump returned nonzero, there should be no way group_exit_code could
have changed from the value do_coredump set.  If you hit one of those
BUG_ON checks, there is a problem I don't understand.  I would like to know
how to reproduce it.


Thanks,
Roland
