Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSFMJfs>; Thu, 13 Jun 2002 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317565AbSFMJfr>; Thu, 13 Jun 2002 05:35:47 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:46855 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317564AbSFMJfr>; Thu, 13 Jun 2002 05:35:47 -0400
Message-ID: <3D0867EA.8090809@loewe-komp.de>
Date: Thu, 13 Jun 2002 11:37:46 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <E17IKo3-000341-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com> you wr
> ite:
> 
>>
>>
>>On Wed, 12 Jun 2002, Peter W=E4chtler wrote:
>>
>>>For the uncontended case: their is no blocked process...
>>>
>>Wrong.
>>
>>The process that holds the lock can die _before_ it gets contended.
>>
>>When another thread comes in, it now is contended, but the kernel doesn't
>>know about anything.
>>
> 
> Note also: this is a feature.
> 
> I have a little helper program which can grab or release a futex in a
> (mmapped) file.  It's great for shell scripts to grab locks.  In this
> case the helper exits with the lock held, and a later invocation
> releases a lock it never held.
> 
> *AND* the lock is persistent across reboots, since it's in a file.
> How cool is that!
> 

Don't want to bugg you: but you would have to clean them up in any case
when you restart your system of cooperating programs.

Posix shmem would be a nice place to store your mmaped file so that it's
gone after reboot - but gives "kernel life time".

And not that I want to put the futexes down: but now I understand why
the PROCESS_SHARED locks on Irix live in the kernel. Yes, perhaps we
should provide both and the app can choose what suits best.


