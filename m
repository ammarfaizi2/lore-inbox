Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289225AbSAVKIh>; Tue, 22 Jan 2002 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSAVKIW>; Tue, 22 Jan 2002 05:08:22 -0500
Received: from zero.tech9.net ([209.61.188.187]:7686 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289225AbSAVKIJ>;
	Tue, 22 Jan 2002 05:08:09 -0500
Subject: Re: 2.4.18pre4aa1
From: Robert Love <rml@tech9.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Dan Chen <crimsun@email.unc.edu>, linux-kernel@vger.kernel.org,
        andrea@suse.de
In-Reply-To: <20020122100230.B20650@flint.arm.linux.org.uk>
In-Reply-To: <20020122074806.A1547@athlon.random>
	<1011682739.17096.563.camel@phantasy> <20020122073742.GA767@opeth.ath.cx> 
	<20020122100230.B20650@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 05:12:28 -0500
Message-Id: <1011694349.850.658.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 05:02, Russell King wrote:
> On Tue, Jan 22, 2002 at 02:37:42AM -0500, Dan Chen wrote:
> > No weird anomalies here. I believe the ones you refer to were a result
> > of ipv6 bits not being updated as well. Russell posted two patches for
> > those.
> 
> No - I do see weirdness in ipv4 as well:

OK, this is the anomaly I spoke of.  Weird ICMP errors.  I've seen
others with this problem.

I don't think we have a proper solution here.

> bash-2.04# uptime
>  10:00am  up 18:57,  1 user,  load average: 0.02, 0.03, 0.00
> bash-2.04# dmesg|grep 'broad'
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> 
> Only one of these happened on boot.  The rest randomly pop up over time.
> I'm going to try tcpdumping lo to see if I can work out what's causing
> them.

	Robert Love

