Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUIJT1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUIJT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUIJT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:27:24 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:47319 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S267850AbUIJTZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:25:03 -0400
Date: Fri, 10 Sep 2004 12:24:59 -0700
Message-Id: <200409101924.i8AJOxRH029788@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sigqueue accounting for posix-timers broken by new RLIMIT_SIGPENDING tracking code
In-Reply-To: Chris Wright's message of  Friday, 10 September 2004 10:42:28 -0700 <20040910104228.K1924@build.pdx.osdl.net>
Emacs: anything free is worth what you paid for it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D'oh.  You are right.  I misread the code in the middle of the night.  I
came across the new issue of hitting the sigpending limit while verifying a
test case for timers leaking.  I failed to realize that it's the timer leak
itself that translates into a sigpending count leak.

Indeed, ignore that patch, and wait for the posix-timers leak fix coming soon.


Thanks,
Roland
