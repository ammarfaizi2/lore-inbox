Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbTGHU3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbTGHU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:29:33 -0400
Received: from cdmx01.nni.com ([216.107.0.100]:46363 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id S267625AbTGHU31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:29:27 -0400
Message-ID: <3F0B2CE6.8060805@nni.com>
Date: Tue, 08 Jul 2003 16:43:18 -0400
From: jhigdon <jhigdon@nni.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Underwood <nemesis-lists@icequake.net>, linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
References: <20030708193401.24226.95499.Mailman@lists.us.dell.com> <20030708202819.GM1030@dbz.icequake.net>
In-Reply-To: <20030708202819.GM1030@dbz.icequake.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Underwood wrote:

>Hi,
>
>  
>
>>That's what per-user process limits are for.  Doesn't matter if it's a
>>shellscript or something else; any system without limits set is
>>vulnerable.
>>    
>>
>
>I agree, but it would also be nice to have a way to clean up after the
>fact without giving up the box.  My limit is set at 2047 processes
>which, while being a lot, doesn't seem like enough to guarantee a dead
>box.  (Don't many busy systems have more than this number running at any
>given time?)
>
>  
>
>>It's a base redhat kernel, after the cannot allocate memory, my system 
>>returned to normal operation and it didnt die.
>>Is this the type of behavior you were looking for? or am i off base?
>>
>>Linux sloth 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 
>>GNU/Linux
>>
>>$ :(){ :|:&};:
>>[1] 3071
>>
>>$
>>[1]+  Done                    : | :
>>
>>$ -bash: fork: Cannot allocate memory
>>-bash: fork: Cannot allocate memory
>>-bash: fork: Cannot allocate memory
>>-bash: fork: Cannot allocate memory
>>    
>>
>
>Nope, on my system running stock 2.4.21, after hitting enter, wait about 2
>seconds, and the system is frozen.  Telnet connects but never gets a
>shell.  None of the SysRq process-killing combos have any effect.  After
>a few failed killalls (which eventually killed the one shell I was able
>to get), and Alt-SysRq-S never completing the sync, I gave up and
>Alt-SysRq-B.
>
>What does ulimit -u say on your system?  2047 on mine.
>
>  
>
$ ulimit -u
3072


Have you tried this on any 2.5.x kernels? Just curious to see what it 
does, I plan on giving it a go later.


