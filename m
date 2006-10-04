Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWJDDLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWJDDLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWJDDLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:11:55 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:17831 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1161067AbWJDDLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:11:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 03:11:40 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efv8pc$31o$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <45229C8E.6080503@redhat.com> <4522A691.7070700@aknet.ru> <4522B7CD.4040206@redhat.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159931500 3128 128.32.168.222 (4 Oct 2006 03:11:40 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 4 Oct 2006 03:11:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper  wrote:
>noexec mounts the way _you_ want them are completely, utterly useless.
>nonexec mounts as they are today plus an upcoming mprotect patch give
>fine grained control.

Are you familiar with the mmap(PROT_EXEC, MAP_ANONYMOUS) loophole?

Even with the upcoming mprotect patch, it will still be straightforward
to circumvent the noexec protections.

>You have to use additional mechanism like SELinux
>to fill in all the holes but that's OK.

Is it even possible to use SELinux to fill in all the holes?  Can you
point me to the SELinux policy that fills in all the holes (including,
for instance, addressing mmap(PROT_EXEC, MAP_ANONYMOUS))?
