Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTEQUbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTEQUbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:31:40 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:48092 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261821AbTEQUbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:31:38 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
References: <x54r3tddhs.fsf@lola.goethe.zz>
	<20030517174100.GT1429@dualathlon.random>
	<x5r86x74ci.fsf@lola.goethe.zz>
	<20030517203045.GZ1429@dualathlon.random>
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 17 May 2003 22:44:16 +0200
In-Reply-To: <20030517203045.GZ1429@dualathlon.random>
Message-ID: <x565o9717j.fsf@lola.goethe.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> > The interactive session tends to be somewhat worse, but the command
> > line version is bad enough for a demonstration.
> 
> this is within emacs:
> 
>    1 blocks with size   95
>    1 blocks with size  146
>    1 blocks with size  175

[...]

>    1 blocks with size  980
>    2 blocks with size  987
>    1 blocks with size  991
>    1 blocks with size  998
>    1 blocks with size 1023
>    8 blocks with size 1024
> 
> from the shell prompt:
> 

[...]

Wel, those are excellent results and as it should be.

> my emacs is:
> 
> GNU Emacs 21.2.1

Same here.

I am talking about the kernel coming with RedHat 9, uname -a gives
Linux lola.goethe.zz 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386 GNU/Linux

Unfortunately, this kernel is here to stay for quite a while, and I
would want to find a way to let Emacs cooperate with it better without
telling people to recompile the kernel or wait a year.

> > Again, I am pretty sure that Emacs is at fault too, but I don't
> > understand the implications of what scheduling behavior causes the
> > pipes to remain mostly empty, with an occasional full filling.  It
> > would be better if Emacs would not be context-switched into the
> > moment something appears in the pipe, but if the writer to the
> > pipe would keep the opportunity to fill'er'up until it is either
> > preempted or needs to wait.  If there was some possibility to
> > force this behavior from within Emacs, this would be good to know.
> 
> I don't see any slowdown here.

Which kernel?  Oh, and of course: on a SMP machine the problem would
not be visible since then the context switch to Emacs does not stop
the other process from stuffing into the pipe.

> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/kernels/v2.4/2.4.21rc2aa1/9998_lowlatency-fixes-12

Taking notice, but will need some time to apply.  And I really would
want to find a way to avoid triggering this problem.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
