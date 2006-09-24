Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWIXXEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWIXXEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWIXXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:04:15 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:12999 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751671AbWIXXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:04:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Sun, 24 Sep 2006 23:04:03 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef72t3$5om$2@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru> <200609242206.20446.vda.linux@googlemail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159139043 5910 128.32.168.222 (24 Sep 2006 23:04:03 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 24 Sep 2006 23:04:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko  wrote:
>If attacker has malicious loaders on the system,
>the situation is already sort of hopeless.

Makes sense.  Of course, nothing prevents an attacker from
introducing malicious loaders, since the loader is an unprivileged
user-level program.

>Stas, I think noexec mounts are meant to prevent
>_accidental_ execution of binaries/libs from that
>filesystem. Think VFAT partition here, where all
>files have execute bits set.

Ok.  That justification makes much more sense to me.  Thanks.  So it's
not really about preventing a malicious attacker from executing a program
on a noexec partition; it's about mischance rather than malice.

That suggests that the question to Stas should be: Do these programs that
you're trying to make work count as example of accidental execution of
binaries on the tmpfs, or are they deliberate execution knowing full well
that the noexec flag is set and damn the consequences?  (If that makes any
sense.)

>If user wants to execute binary blob from that fs
>bad enough, he will do it. Maybe just by
>copying file first to /tmp.

Right.  Agreed.
