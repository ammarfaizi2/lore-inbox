Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270443AbTHBUaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTHBUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:30:17 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38844 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270443AbTHBUaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:30:14 -0400
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
From: Nicholas Miell <nmiell@attbi.com>
To: Roland McGrath <roland@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308021908.h72J82x10422@magilla.sf.frob.com>
References: <200308021908.h72J82x10422@magilla.sf.frob.com>
Content-Type: text/plain
Message-Id: <1059856202.1374.12.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 13:30:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 12:08, Roland McGrath wrote:
> The problem exists with uids/gids as well, in the sense that they are
> changed per-thread but POSIX semantics are that setuid et al affect the
> whole process (i.e. all threads in a thread group).

Is there any particular reason why the POSIX semantics are desirable
(besides "that's the way POSIX says it should be")?

Personally, I can think of no benenfit to per-process uids/gids, and
several scenarios where per-thread uids/gids would be good. (Think of a
multi-threaded server handling connections from N different users on N
threads, or a 1 thread per CPU server handling many different user
connections, or a multi-threaded web server running perl/php/etc. stuff
as different users in different threads.)

Just wondering, Nicholas.

