Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264390AbUDSMoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUDSMoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:44:44 -0400
Received: from dx.caltech.edu ([131.215.159.62]:45473 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264390AbUDSMon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:44:43 -0400
Message-Id: <200404191245.i3JCjqal006292@localhost.localdomain>
Reply-To: <stl@nuwen.net>
From: "Stephan T. Lavavej" <stl@nuwen.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Process Creation Speed
Date: Mon, 19 Apr 2004 05:44:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQmB2aH9UyurbWsSZeBgJQMWokuFQAA7zog
In-Reply-To: <20040419120957.GB3764@convergence.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all who have responded.

I had been measuring the time to create and terminate a do-nothing program.
I had not been measuring CGI programs, though that was why I was doing the
measurement in the first place.

I changed my measurement strategy, and I now get about 110 microseconds for
creation and termination of a do-nothing process (fork() followed by
execve()).  Statically linking everything gave a significant speedup, which
allowed me to reach that value.  This was on a 2.6.x kernel.  110
microseconds is well within my "doesn't suck" range, so I'm happy - CGI will
be fast enough for my needs, and I can always turn to FastCGI later if
necessary.

I am writing a web-based forum entirely in C++, rejecting interpreted
languages (Perl, PHP, ASP, etc.) and relational databases (MySQL,
PostGreSQL, etc.) entirely.  My forum consists of "kiddy" CGI processes
which talk over the network to a persistent "mommy" daemon who keeps all
forum state in main memory.

My code runs on both Windows and GNU/Linux with no configuration needed, but
separate measurements indicate that XP takes about 3.3 ms to create and
terminate a do-nothing process.  Thus it looks like Linux 2.6.x will be the
kernel of choice for my forum.

Thanks again!

Stephan T. Lavavej
http://nuwen.net


