Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283762AbRK3SnL>; Fri, 30 Nov 2001 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283759AbRK3SnC>; Fri, 30 Nov 2001 13:43:02 -0500
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:47887 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S283764AbRK3SmP>; Fri, 30 Nov 2001 13:42:15 -0500
Message-ID: <005201c179ce$b91ca290$2e040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Jessica Blank" <jessica@twu.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net>
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the problem!
Date: Fri, 30 Nov 2001 13:42:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a fix to Solaris for this-- or a "workaround", I should
> say:
>
> http://www.sun.com/sun-on-net/performance/tcp.slowstart.html

This is a workaround for a TCP problem which you probably don't have based
on your comments below.  Why do I think you don't have this problem?  See
below.

> It is high time this problem is acknowledged and FIXED. I am
> forced to share a network with a bunch of NT servers, some of which get
> plenty of traffic-- enough so that they manage to crowd out my machine to
> the tune of 600ish ms ping times to the Linux box versus only **70**
> (!!!!!!) to the Windows box. THESE MACHINES ARE ON THE SAME NETWORK, but
> the Linux box is as sluggish, latency-wise, as telnetting into a box on a
> MODEM-- whereas the Windows box, where latency isn't even as important (no
> one telnets into them), is nice and zippy.

This fix applies to slow start for TCP connections that usually involve
things like streaming, etc.  You noted in your email that ping had high
latency times, well, ping is ICMP, not TCP, and does not use slow start.
Also, interactive TCP sessions such as telnet/ssh are very unlikely to show
a problem with slow start.

Later,
Tom


