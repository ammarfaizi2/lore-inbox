Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316743AbSERB5h>; Fri, 17 May 2002 21:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316745AbSERB5g>; Fri, 17 May 2002 21:57:36 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:39128 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316743AbSERB5f>;
	Fri, 17 May 2002 21:57:35 -0400
Date: Fri, 17 May 2002 18:57:35 -0700
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question : Broadcast Inter Process Communication ?
Message-ID: <20020517185735.A30559@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020517143052.A30047@bougret.hpl.hp.com> <873cwqrzmm.fsf@goat.bogus.local>
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

On Sat, May 18, 2002 at 03:52:33AM +0200, Olaf Dietsche wrote:
> Hi Jean,
> 
> > 	This "one sender - multiple reader" model seems common and
> > usefull enough that there must be a way to do that under Linux. I know
> > that it exist under Windows. Can somebody help me to find out how to
> > do it under Linux ?
> 
> 
> Maybe, you're looking for multicast. But you need a TCP/IP stack for
> this and I don't know, wether this is implemented in Linux.

	I've used multicast with great success in the past and I know
that it's possible to bind a multicast socket on an interface. So,
basically I would bind a multicast socket on the loopback. That what I
was refering to in my e-mail by "UDP broadcast".
	But, it just seems to me inefficient to have to go through all
the way down in the network stack to the loopback interface (through
IP and TCP) just for simple IPC. A multicast unix socket would be much
more efficient (because it would no mess with any headers and support
higher MTU).

> Regards, Olaf.

	Thanks...

	Jean
