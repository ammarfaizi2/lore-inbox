Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267718AbTGHVo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267722AbTGHVo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:44:29 -0400
Received: from 69.Red-217-126-207.pooles.rima-tde.net ([217.126.207.69]:29701
	"EHLO server01.nullzone.prv") by vger.kernel.org with ESMTP
	id S267718AbTGHVoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:44:25 -0400
Message-Id: <5.2.1.1.2.20030708235404.02b9ec80@192.168.2.130>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 08 Jul 2003 23:59:04 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Re: Forking shell bombs
In-Reply-To: <3F0B2CE6.8060805@nni.com>
References: <20030708202819.GM1030@dbz.icequake.net>
 <20030708193401.24226.95499.Mailman@lists.us.dell.com>
 <20030708202819.GM1030@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

    Debian 3.0 (woody) stable. Kernel 2.4.21 ...
    bash 2.05a

$ulimit -u
1791

---

No problems here. In 1-2 secs the process dies and all is ok, i can work 
with the shell without any problem.

Seeya


At 16:43 08/07/2003 -0400, jhigdon wrote:
>Ryan Underwood wrote:
>
>>Hi,
>>
>>
>>
>>>That's what per-user process limits are for.  Doesn't matter if it's a
>>>shellscript or something else; any system without limits set is
>>>vulnerable.
>>>
>>
>>I agree, but it would also be nice to have a way to clean up after the
>>fact without giving up the box.  My limit is set at 2047 processes
>>which, while being a lot, doesn't seem like enough to guarantee a dead
>>box.  (Don't many busy systems have more than this number running at any
>>given time?)
>>
>>
>>
>>>It's a base redhat kernel, after the cannot allocate memory, my system 
>>>returned to normal operation and it didnt die.
>>>Is this the type of behavior you were looking for? or am i off base?
>>>
>>>Linux sloth 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 
>>>GNU/Linux
>>>
>>>$ :(){ :|:&};:
>>>[1] 3071
>>>
>>>$
>>>[1]+  Done                    : | :
>>>
>>>$ -bash: fork: Cannot allocate memory
>>>-bash: fork: Cannot allocate memory
>>>-bash: fork: Cannot allocate memory
>>>-bash: fork: Cannot allocate memory
>>>
>>
>>Nope, on my system running stock 2.4.21, after hitting enter, wait about 2
>>seconds, and the system is frozen.  Telnet connects but never gets a
>>shell.  None of the SysRq process-killing combos have any effect.  After
>>a few failed killalls (which eventually killed the one shell I was able
>>to get), and Alt-SysRq-S never completing the sync, I gave up and
>>Alt-SysRq-B.
>>
>>What does ulimit -u say on your system?  2047 on mine.
>>
>>
>$ ulimit -u
>3072
>
>
>Have you tried this on any 2.5.x kernels? Just curious to see what it 
>does, I plan on giving it a go later.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




