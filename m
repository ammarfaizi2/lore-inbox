Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWIXWtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWIXWtz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIXWtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:49:55 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:22969 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932126AbWIXWty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:49:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Sun, 24 Sep 2006 22:49:42 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef7226$5om$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516C9D0.3080606@aknet.ru> <ef6ldq$uup$1@taverner.cs.berkeley.edu> <FE51C682-23F0-4BFE-AA3F-E3B74F9D6E3A@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159138182 5910 128.32.168.222 (24 Sep 2006 22:49:42 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 24 Sep 2006 22:49:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett  wrote:
>On Sep 24, 2006, at 15:14:02, David Wagner wrote:
>> I'm curious about this, too.  ld-linux.so is a purely unprivileged
>> program.  It isn't setuid root.  Can you write a variant of ld- linux.so
>> that reads an executable into memory off of a partition mounted noexec and
>> then begins executing that code?  (perhaps by using anonymous mmap with
>> PROT_EXEC or some other mechanism) It sure seems like the answer would
>> be yes.  If so, I'm having a hard time understanding what guarantees
>> noexec gives you.  Isn't the noexec flag just a speedbump that raises
>> the bar a little but doesn't really prevent anything?
>
>I seem to recall somewhere that it was possible to prevent anonymous
>memory from being mapped PROT_EXEC during or after being mapped
>PROT_WRITE; and that in fact your average SELinux-enabled system had
>such protections for everything but the Java binary and a few other
>odd programs.  If you can't ever execute any data blobs except those
>that came directly from a properly-secured SELinux-enabled filesystem
>it makes exploiting a server significantly harder.

Interesting.  You're probably right.  Thanks.

I don't mean to sound ungrateful, but I'm still curious about my original
question (which I don't believe has been answered).  To be honest, I
wasn't asking whether it was possible to configure Linux or SELinux in
a way that blocks this "attack"; I was more interested in whether this
"attack" will succeed against a stock Linux system.  If you have any
thoughts on that question, I'd be interested to hear them.  I notice that
the original poster has raised essentially this point more than once,
too, but never got any response, either.
