Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbRGJMej>; Tue, 10 Jul 2001 08:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbRGJMe3>; Tue, 10 Jul 2001 08:34:29 -0400
Received: from wretched.demon.co.uk ([193.237.109.203]:62479 "EHLO
	linux1.wretched.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266250AbRGJMeQ>; Tue, 10 Jul 2001 08:34:16 -0400
Message-ID: <3B4AF64C.B801E8DB@wretched.demon.co.uk>
Date: Tue, 10 Jul 2001 13:34:20 +0100
From: Simon Waters <Simon@wretched.demon.co.uk>
Reply-To: Simon@wretched.demon.co.uk
Organization: Eighth Layer Limited
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Progress Re: IP DoS on 2.2.17
In-Reply-To: <3B48829E.1975F8E4@wretched.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Waters wrote:
> 
> Please excuse a post from a non-member, but this seems the
> most suitable place I could find. Please e-mail me any
> thoughts, and I'll summarise if I make any progress.

The problem also occurs with 2.2.19. 

Symptoms are identical, following some sort of port scan,
outgoing packets are dropped until you remove kernel modules
down to and including slhc.

Demon users report a steady drip of problems related to
compression of ISDN and Linux, including today a panic - I'm
digging there for kernel versions etc.

I'm going to mindlessly stare at the source code for slhc.c
and see if I'm inspired.
 
> Should I upgrade to 2.2.19 and hope it goes away?

It doesn't.
 
> Any one any idea on the scanner in use? If I could reproduce
> the problem at will I'd be in a better position to analyse
> what is happening.

No news here. 

I haven't found any neat tools either - pondering netcat and
portsentry, netcat at least lets me run an arbitary program
on receipt of an arbitary UDP IP packet, I guess I was
hoping for something like IPtrap that sets TCPHOPSTIP before
running an arbitary program....

I'll try hacking netcat's GAPING_SECURITY_HOLE section....

However if it is slhc.c getting muddled it could be a
combination of packets, rather than just one bad egg. This
is all a bit lower than the kind of IP problems I usually
deal with.

Meanwhile maybe I'll tcpdump the port 111 traffic, and see
if the PEN-TEST list guys know what is hitting me.
 
> I don't understand why I am the only one seeing this (I
> found some promising references, only to find they were many
> kernel revisions out of date) - it is a very infrequent
> problem (Despite seeing scans against port 111 every few
> hours, I've only seen this problem a handful of times).
> 
> Maybe others just assume it is yet another ISP problem and
> reboot?!, but the ability to only get incoming packets is
> rather distinctive (Although I only spotted this as I
> happened to have pload running).

I'm siding more with the nobody else has figured out what is
wrong school of thought, and perhaps it only occurs with
specific configurations.

Replies as before by e-mail - thanks for the two replies so
far. Good ideas both.

	Simon
