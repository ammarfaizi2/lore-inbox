Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752137AbWIXTOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbWIXTOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbWIXTOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:14:12 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:910 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1752137AbWIXTOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:14:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Sun, 24 Sep 2006 19:14:02 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef6ldq$uup$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159125242 31705 128.32.168.222 (24 Sep 2006 19:14:02 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 24 Sep 2006 19:14:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>Ulrich Drepper wrote:
>> The consensus has been to add the same checks to mprotect.  They were
>> not left out intentionally.
>
>But how about the anonymous mmap with PROT_EXEC set?

I'm curious about this, too.  ld-linux.so is a purely unprivileged
program.  It isn't setuid root.  Can you write a variant of ld-linux.so
that reads an executable into memory off of a partition mounted noexec and
then begins executing that code?  (perhaps by using anonymous mmap with
PROT_EXEC or some other mechanism) It sure seems like the answer would
be yes.  If so, I'm having a hard time understanding what guarantees
noexec gives you.  Isn't the noexec flag just a speedbump that raises
the bar a little but doesn't really prevent anything?
