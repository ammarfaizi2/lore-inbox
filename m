Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288059AbSAMUCE>; Sun, 13 Jan 2002 15:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288060AbSAMUBy>; Sun, 13 Jan 2002 15:01:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:13074 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288059AbSAMUBu>;
	Sun, 13 Jan 2002 15:01:50 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: jogi@planetzork.ping.de, Ed Sweetman <ed.sweetman@wmich.edu>,
        Andrea Arcangeli <andrea@suse.de>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3C41E415.9D3DA253@zip.com.au>
In-Reply-To: <20020113184249.A15955@planetzork.spacenet>,
	<E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy>
	<20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet>
	<20020112095209.A5735@hq.fsmlabs.com>
	<20020112180016.T1482@inspiron.school.suse.de>
	<005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> 
	<20020113184249.A15955@planetzork.spacenet>
	<1010946178.11848.14.camel@phantasy>  <3C41E415.9D3DA253@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 15:04:35 -0500
Message-Id: <1010952276.12125.59.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 14:46, Andrew Morton wrote:

> I can't say that I have ever seen any significant change in throughput
> of anything with any of this stuff.

I can send you some numbers.  It is typically 5-10% throughput increase
under load.  Obviously this work won't help a single task on a single
user system.  But things like (ack!) dbench 16 show a marked
improvement.

> Benchmarks are well and good, but until we have a solid explanation for
> the throughput changes which people are seeing, it's risky to claim
> that there is a general benefit.

I have an explanation.  We can schedule quicker off a woken task.  When
an event occurs that allows an I/O-blocked task to run, its time-to-run
is shorter.  Same event/response improvement that helps interactivity.

	Robert Love

