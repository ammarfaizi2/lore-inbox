Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRJUSXp>; Sun, 21 Oct 2001 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276534AbRJUSXg>; Sun, 21 Oct 2001 14:23:36 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:64385 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S276522AbRJUSX3>; Sun, 21 Oct 2001 14:23:29 -0400
Date: Mon, 22 Oct 2001 02:23:57 +0800 (PHT)
From: Federico Sevilla III <jijo@leathercollection.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] updated preempt-kernel
In-Reply-To: <1003562833.862.65.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0110220216500.21933-100000@gusi.leathercollection.ph>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Oct 2001 at 03:27, Robert Love wrote:
> A preemptible kernel.  It lowers your latency.

I'm using 2.4.12-xfs with the preempt-kernel-rml-1 patch. Just this
morning I noticed a minute or so of the system being in "freeze". There
was no significant disk activity, my open windows were working (ICQ,
IPTraf under wterm, Opera), but things like opening a new wterm would work
but no prompt (bash) would come out, or "ps ax" on a system with stay
there.

In the IPTraf window I saw a lot of domain lookups going back and forth.
Since IPTraf does reverse name lookups I quit it to hopefully bring down
the load. I'm running bind 9.1.3. After the freeze everything was 100%
normal. I checked the syslog and found close to a hundred lines one after
the other about named complaining of a lame server.

I am under the impression that it was bind hogging system resources,
although I do not know how to look at historical data of memory usage and
CPU usage for such a small time.

I am curious, what does the preempt patch do for such situations? I
honestly don't know how the system would have felt otherwise (if I didn't
have support for preemption). And it's not so easy to reproduce since I
don't cause this myself.

Thanks for your input, and I'll give your second patch a shot as soon as I
can. :)

 --> Jijo

--
Federico Sevilla III  :: jijo@leathercollection.ph
Network Administrator :: The Leather Collection, Inc.
GnuPG Key: <http://jijo.leathercollection.ph/jijo.gpg>

