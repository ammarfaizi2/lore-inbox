Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268477AbTBOBUm>; Fri, 14 Feb 2003 20:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268482AbTBOBUm>; Fri, 14 Feb 2003 20:20:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49673 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268477AbTBOBUk>;
	Fri, 14 Feb 2003 20:20:40 -0500
Message-ID: <3E4D981D.209@pobox.com>
Date: Fri, 14 Feb 2003 20:30:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
References: <Pine.LNX.4.44.0302141704280.1296-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302141704280.1296-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 15 Feb 2003, Matti Aarnio wrote:
> 
>>Do we need new syscall(s) ?  Could it all be done with netlink ?
> 
> 
> We'd need the same new system call - the one to associate signals of this 
> process with the netlink thing.
> 
> (Yeah, the "system call" could be an ioctl entry, but quite frankly, 
> that's much WORSE than adding a system call. It's just system calls 
> without type checking).


I have been lobbying for sys_garzik(2) for years... while you're in 
there adding stuff, can you slip that in too please?

... :)

More seriously, and a bit of a tangent, I wonder how much attention we 
need to give netlink.  Because it either has the potential to be used as 
a de facto in-kernel event-passing API, or it's too heavyweight for 
that, implying [IMO] we need a netlink-lite.

I _don't_ want to see mini-netlinks springing up every time we need 
[a]sync <foo> delivery inside the kernel.

	Jeff



