Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWCUFdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWCUFdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWCUFdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:33:09 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:62670 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030324AbWCUFdI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:33:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PfsIk4tAiQE8pSyuR2fHRjWC3mm9u4Br3y3Q2FakUBd29hT4rs/f3W9Q3cj4m29zfw9O2GyUelRVh/U0DLKG4lpxlxbvPyWQZT+wIwckGGbQXJnmyWSyIZ4E3qQi4t0IiQISUNhurZr/EfxNOyUEUx3vyffaLR6yXpjeePNE3KM=
Message-ID: <787b0d920603202133i123b51deif114a75b0d9c9d29@mail.gmail.com>
Date: Tue, 21 Mar 2006 00:33:07 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: bert.hubert@netherlabs.nl, linux-kernel@vger.kernel.org, george@mvista.com,
       andi@rhlx01.fht-esslingen.de, hirofumi@mail.parknet.co.jp,
       kernel@kolivas.org
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert writes:

> Not only is the pm timer slow by design, it also needs to be read
> multiple times to work around a bug in certain hardware.
>
> What is new is that this option is now dependent on CONFIG_EMBEDDED.
> Unless you select this option, the PM Timer will always be used.

Good. Fast but horribly buggy is NOT acceptable as a default.
Go ahead and tweak the settings on YOUR system. Run Gentoo.

I wasted a lot of time trying to figure out why my clock ran
about 1.414 (yes, square root of two) times faster than proper.
It turns out that a normal dual-core AMD box has TSCs that run
at randomly varying and fully independant rates. Before I found
a post to linux-kernel by an AMD employee explaining this, my
thought was that I was probably missing clock ticks from the
BIOS going into SMM mode. That was the problem the previous time
I had clock problems. (so I reduced HZ to 100, etc.)

I'm sure lots of people would never figure out why their clock
is running 41.4% faster than normal. They'd live with it, using
a physical clock mounted on the wall, or switch to a different OS.
