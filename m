Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTGHUNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTGHUNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:13:46 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:31759 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265295AbTGHUNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:13:44 -0400
Date: Tue, 8 Jul 2003 15:28:19 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030708202819.GM1030@dbz.icequake.net>
References: <20030708193401.24226.95499.Mailman@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030708193401.24226.95499.Mailman@lists.us.dell.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> That's what per-user process limits are for.  Doesn't matter if it's a
> shellscript or something else; any system without limits set is
> vulnerable.

I agree, but it would also be nice to have a way to clean up after the
fact without giving up the box.  My limit is set at 2047 processes
which, while being a lot, doesn't seem like enough to guarantee a dead
box.  (Don't many busy systems have more than this number running at any
given time?)

> It's a base redhat kernel, after the cannot allocate memory, my system 
> returned to normal operation and it didnt die.
> Is this the type of behavior you were looking for? or am i off base?
> 
> Linux sloth 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 
> GNU/Linux
> 
> $ :(){ :|:&};:
> [1] 3071
> 
> $
> [1]+  Done                    : | :
> 
> $ -bash: fork: Cannot allocate memory
> -bash: fork: Cannot allocate memory
> -bash: fork: Cannot allocate memory
> -bash: fork: Cannot allocate memory

Nope, on my system running stock 2.4.21, after hitting enter, wait about 2
seconds, and the system is frozen.  Telnet connects but never gets a
shell.  None of the SysRq process-killing combos have any effect.  After
a few failed killalls (which eventually killed the one shell I was able
to get), and Alt-SysRq-S never completing the sync, I gave up and
Alt-SysRq-B.

What does ulimit -u say on your system?  2047 on mine.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
