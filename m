Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTKZTFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTKZTFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:05:04 -0500
Received: from dsl-sj-66-219-74-27.broadviewnet.net ([66.219.74.27]:29570 "EHLO
	server.perens.com") by vger.kernel.org with ESMTP id S264284AbTKZTE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:04:59 -0500
Message-ID: <3FC4F94F.6030801@perens.com>
Date: Wed, 26 Nov 2003 11:04:47 -0800
From: Bruce Perens <bruce@perens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org> <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com> <3FC4F248.8060307@perens.com> <Pine.LNX.4.58.0311261037370.1524@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311261037370.1524@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happened is that I attempted to simplify the test code to send to 
you, and simplified out the problem by using
kill() instead of causing a fault. :-)

It's just what you describe here:

>One difference in 2.4.x and 2.6.x is the signal blocking wrt blocked
>signals that are _forced_ (ie anything that is thread-synchronous, like a
>SIGSEGV/SIGTRAP/SIGBUS that happens as a result of a fault):
>
> - in 2.4.x they will just punch through the block
> - in 2.6.x they will refuse to punch through a blocked signal, but
>   since they can't be delivered they will cause the process to be
>   killed
>  
>
The behavior of 2.4 seems to be the same used by some dozens of Unix 
systems upon which my confidence test passed.

I agree that we should not be wrong in the same way as everyone else, 
and wonder if POSIX says anything about this. I could have been the only 
one using this "feature".

    Thanks

    Bruce


