Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTJXVBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTJXVBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:01:06 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:1801 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262621AbTJXVBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:01:03 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: posix capabilities inheritance
Date: Fri, 24 Oct 2003 20:58:54 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bnc3qe$kab$1@abraham.cs.berkeley.edu>
References: <fa.n4rmmgg.2423pm@ifi.uio.no> <3F98E674.6090104@stanford.edu> <20031024124150.GA5609@thunk.org> <3F9956E6.2020709@stanford.edu>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1067029134 20811 128.32.153.211 (24 Oct 2003 20:58:54 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 24 Oct 2003 20:58:54 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski  wrote:
>I've been programming Windows for a long time, and windows has a 
>capability system.  [...] All capabilities are disabled by default (almost -- 
>there's a pointless exception, of course).  The result is that every 
>program that uses a privileged function (e.g. change the time, restart, 
>etc.) wraps that call with something that turns enables the capability 
>at first, then disables it.  This has no benefit -- a hijacked 
>privileged program can still enable them, and the admin never sees this, 
>because everything enables them.

Actually, it does have some benefits.  If I do an open() somewhere
else in the code, I know that it is not going to unintentionally use
my elevated privileges.  That's useful.  Least privilege, and all that.
