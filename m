Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310490AbSCCAoG>; Sat, 2 Mar 2002 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310491AbSCCAn4>; Sat, 2 Mar 2002 19:43:56 -0500
Received: from trillium-hollow.org ([209.180.166.89]:25535 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310490AbSCCAnh>; Sat, 2 Mar 2002 19:43:37 -0500
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sun, 03 Mar 2002 00:33:51 GMT."
             <20020303003351.B6120@flint.arm.linux.org.uk> 
Date: Sat, 02 Mar 2002 16:43:23 -0800
From: erich@uruk.org
Message-Id: <E16hK5z-0000vI-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King <rmk@arm.linux.org.uk> wrote:

> On Sat, Mar 02, 2002 at 04:21:24PM -0800, erich@uruk.org wrote:
> > The fact that the routing layer and application layers of Linux's
> > TCP/IP stack are one and the same is a difficulty here which the
> > IP firewalling code in Linux does not fix.  I.e. if I wanted to
> > have routing as well, but not accept any packets internally *not*
> > destined for my interface, I'm not sure how to specify it without
> > something like TCP wrappers, as sleazy as they can be, and they
> > don't offer this kind of capability in general as is.
> 
> Linux 2.4 netfilter:
> 
> Incoming                                                 Outgoing
> interface                                                interface
>   ----+------------------- FORWARD -----------------+------->
>       |                                             ^
>       v                                             |
>     INPUT -------------> Application -----------> OUTPUT
> 
> The names in capitals are the names of the tables.  You can control
> packets that the local machine sees completely independently of what
> gets routed through the machine with a kernel supporting iptables
> by adding the appropriate rules to the input and forward tables.

Hmm.  This would seem to be false in the RH 7.2 kernel 2.4.9-21
kernel I'm working with.

My IP masquerading rule (which claims to be in the "forward"
chain, with target "MASQ"), was blocked when I did input address
masking.

I.e. Yes, I actually tested this before posting.

If you're calling it a bug, then so be it.  But the result would be
a bit better than how my Linux system works now.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
