Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSHBP4h>; Fri, 2 Aug 2002 11:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSHBP4h>; Fri, 2 Aug 2002 11:56:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316217AbSHBP4f>; Fri, 2 Aug 2002 11:56:35 -0400
Date: Fri, 2 Aug 2002 08:56:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
 2.5.29)
In-Reply-To: <1028289587.18317.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208020850550.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Aug 2002, Alan Cox wrote:
>
> 2% is way too much for a lot of applications. Thats 28 minutes a day

Note that _most_ PC clocks are a hell of a lot better than 2% a day, so
that was really meant as the worst case for fairly broken hardware. But it
apparently does happen.

A more realistic schenario is less than 0.1%, but with the caveat that if
the machine goes to sleep, the error goes up to infinity..

(Think of the current "jiffies" update and gettimeofday() _without_ any
ntp or /etc/adjtime. For most people it is good enough to use as a wall
clock. But some people literally lose or gain a minute every hour.
That's the kind of drift I'm talking about).

			Linus

