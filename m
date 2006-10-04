Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWJDEVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWJDEVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWJDEVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:21:44 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:37022 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932365AbWJDEVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:21:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 04:21:27 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efvcs7$526$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4522B7CD.4040206@redhat.com> <efv8pc$31o$1@taverner.cs.berkeley.edu> <a36005b50610032051h64609d51kf1e5211d1bf07370@mail.gmail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159935687 5190 128.32.168.222 (4 Oct 2006 04:21:27 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 4 Oct 2006 04:21:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
>On 10/3/06, David Wagner <daw@cs.berkeley.edu> wrote:
>> Are you familiar with the mmap(PROT_EXEC, MAP_ANONYMOUS) loophole?
>
>Another person who doesn't know about SELinux.  Read
>
>http://people.redhat.com/drepper/selinux-mem.html

You're right, I didn't know about that one.  Thanks for the
education and for taking the time to respond.

I wonder whether it is feasible to run with allow_exec{heap,mem,mod,stack}
all set to false, on a real system.  Is there any example of a fully
worked out SELinux policy that has these set to false?  FC5 has
allow_execheap set to false and all others set to true in its default
SELinux policy, so it looks like the mmap(PROT_EXEC, MAP_ANONYMOUS)
loophole remains open in FC5 by default.  My concern would be that setting
all of the exec-related booleans to false might break so much code that
setting them all to false wouldn't be feasible in practice.  If so,
the theoretical possibility to close the mmap(PROT_EXEC, MAP_ANONYMOUS)
loophole may be one of these things that is possible in theory but not
in practice.
