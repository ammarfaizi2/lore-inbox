Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316640AbSERCyj>; Fri, 17 May 2002 22:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSERCyj>; Fri, 17 May 2002 22:54:39 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48869 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316640AbSERCyi>;
	Fri, 17 May 2002 22:54:38 -0400
Date: Fri, 17 May 2002 19:54:38 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question : Broadcast Inter Process Communication ?
Message-ID: <20020517195438.A30640@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020517143052.A30047@bougret.hpl.hp.com> <E178uWc-0007mP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 04:04:52AM +0100, Alan Cox wrote:
> > 	This "one sender - multiple reader" model seems common and
> > usefull enough that there must be a way to do that under Linux. I know
> > that it exist under Windows. Can somebody help me to find out how to
> > do it under Linux ?
> 
> Its actually a nontrivial construct - especially since readers can vanish
> and appear asynchronously during the lifetime of any event.

	That's exactly why I don't want to deal with it myself.
	However, the kernel deal with it all the time, and do it
well. For example RtNetlink event have this property (except that they
are kernel => process instead of beeing process => process).

> You could 
> implement it with multiple linked lists of pointers to refcounted objects,
> and you could do that in user space (eg with shared memory), the chances
> are that for all but the most extreme cases sending a copy of the event to
> each listener is cheaper, simpler and more debuggable

	Well, maybe I will simply use a UDP broadcast on the loopback,
it seems much simpler to me. I really wish there was broadcast Unix
sockets.

	Regards,

	Jean
