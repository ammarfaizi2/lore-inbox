Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbTCYPJs>; Tue, 25 Mar 2003 10:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbTCYPJr>; Tue, 25 Mar 2003 10:09:47 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:30086 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S262678AbTCYPJq>;
	Tue, 25 Mar 2003 10:09:46 -0500
Date: Tue, 25 Mar 2003 15:20:51 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance with pcnet32 on SMP
In-Reply-To: <3E7B5B41.2070308@us.ibm.com>
Message-ID: <Pine.LNX.4.53.0303251433160.18798@skynet>
References: <Pine.LNX.4.53.0303202346220.3340@skynet> <3E7B5B41.2070308@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Dave Hansen wrote:

> I have the same kind of machine.  I've seen the same problems, but
> they're intermittent; I haven't been able to really discern a pattern.

Neither can I. I did not that sometimes between subsequent boots, I could
get either 300B/s or 7kB/s for no apparent reason.

> I have the feeling that part of the problem may be with the machine on
> the other side of the connection.
>

I tried a few different machines but they are all using a 2.4.x kernel of
some description. It still is a lot more reliable if SMP is disabled.

> Yeah, kirq was causing that and it _was_ broken for a bit.  It should
> have been fixed by 2.5.64, though.
>

I'm not sure and I don't have the expertise to track down the problem.
After a session of Devils Guide To Debugging[1], I could not find any
pattern that determined performance. I tried loading the module full
duplex at 100mb (it still resolves to 10mb at half-duplex) and various
combinations of smp_affinity but it still is very poor. Curiously enough,
trying to load it at 100mb and full_duplex makes it perform more
predictably. It's still bad (3 to 7 kB/s), but bad at a consistant level.
I suspect this observation exists purely inside my own head though. I
tried turning off ACPI but it made no difference.

I did note that I get decent performance to a 2.4 UP box that is on the
same subnet as me. I am not sure if it is relevant but the computer I am
getting really bad performance with is on another subnet behind a
firewall even though it is on the same LAN.

I am going to leave it for the moment anyway as I am getting nowhere with
the problem. Thanks for your time and if there is any other suggestions,
I'd be happy to try them out.

Mel

[1] Change things at random until something works
