Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269287AbUIAAOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269287AbUIAAOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIAANx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:13:53 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:60046 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S264261AbUIAALg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:11:36 -0400
Date: Tue, 31 Aug 2004 17:11:32 -0700
Message-Id: <200409010011.i810BW5S001885@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: OGAWA Hirofumi's message of  Tuesday, 31 August 2004 22:19:04 +0900 <87k6vfqwc7.fsf@devron.myhome.or.jp>
X-Zippy-Says: I can see you GUYS an' GALS need a LOT of HELP...You're all very
   STUPID!!  I used to be STUPID, too..before I started watching
   UHF-TV!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should we also clean up and improve those with user-visible change?
> Those should be thought as separate issue?

The first answer to give is to the second question: yes, this is a
separate subject from the implementation changes we are discussing right
now.  I don't really want to get into discussing a different interface at
the moment, because I have more than enough to do this week already.

It is certainly something I have considered.  Cleaning up ptrace for use
on multi-threaded processes was no fun at all.  Dan Jacobowitz and I have
talked about this before, and my tendency is the same he mentioned, to
start along the lines of the Solaris /proc interface.  (However, I would
not make Solaris compatibility a priority over implementation sanity.)
But like I said, not for this week!

An important step to a sane and clean implementation of whatever new
interface will be to clean up the machine-specific parts of the
implementation that are required.  If I am ever going to work on this
code again and not turn homicidal, it needs to take the form of a general
framework for special state examination/mutation requests machines
require uses common code to present these in whatever new interface and
compatibly for the ptrace requests that now exist.  More for not this week.

I'd be happy to discuss details of all this stuff with anyone interested
in helping make it happen.  But, you know, later.


Thanks,
Roland
