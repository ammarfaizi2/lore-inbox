Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131267AbRCNAbx>; Tue, 13 Mar 2001 19:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131272AbRCNAbn>; Tue, 13 Mar 2001 19:31:43 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:35991 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S131267AbRCNAb0>;
	Tue, 13 Mar 2001 19:31:26 -0500
Date: Wed, 14 Mar 2001 00:20:21 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Bob_Tracy <rct@gherkin.sa.wlk.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: another Cyrix/mtrr problem?
In-Reply-To: <m14cuLL-0005khC@gherkin.sa.wlk.com>
Message-ID: <Pine.LNX.4.31.0103140009230.7143-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Bob_Tracy wrote:

> System is a Tyan S1590S motherboard (Apollo MVP3 chipset) with
> Cyrix MII 300 processor, NVIDIA GeForce2 MX AGP video card, 2.4.2
> kernel, XFree86-4.0.2, and the NVIDIA 0.9-6 driver.

Normally the answer would be "Closed driver, complain to nVidia",
but just in case..
First I suggest you try the new drivers that came out for it today
first though, to see if that fixes your problem.

> Jeff Hartmann (AGPGART support) thinks this is probably a MTRR issue.
> I'm leaning that way, given a recent posting by someone else having
> MTRR problems with his Cyrix 6x86.

The recent problems were only in Alans 2.4.2-ac tree, not in the
main Linus branch. They should also have only happened on Athlons
that was introduced by the addition Cyrix III support.
2.4.2-ac20 fixes this.

As no-one else afaik has complained about Cyrix MII MTRR support,
I think this is an isolated incident, which is why I'm pointing a
finger at the binary drivers, but...

There is the possibility that you're the first MII owner to notice
that this is broken. Can you verify that..

 a. You have MTRR support compiled into the kernel.
 b. You have a /proc/mtrr file
 c. You can add/delete ranges using /proc/mtrr
    (See Documentation/mtrr.txt for info on how to do this)

If yes,yes,yes, it is a broken driver, and you should complain
to nVidia, not linux-kernel.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

