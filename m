Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRHFPHm>; Mon, 6 Aug 2001 11:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268715AbRHFPH2>; Mon, 6 Aug 2001 11:07:28 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:56749 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S268691AbRHFPGy>; Mon, 6 Aug 2001 11:06:54 -0400
Date: Mon, 6 Aug 2001 16:08:17 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@chiara.elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <Pine.GSO.3.96.1010806161212.14836C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0108061605560.3733-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Maciej W. Rozycki wrote:

> On Fri, 3 Aug 2001, Mark Hemment wrote:
>
> >   The problem is the MP table contains no configuration blocks, and a zero
> > local APIC address.  I've attached the full boot messages.
> >
> >   The work around is trap that there are no config blocks, and fall back
> > to UP.  Patch attached.
>
>  The following patch should be better -- all the handling is performed at
> the table parsing stage as it should.  Could you please test it?  It
> applies to -ac7 cleanly as well.


  I can't test it at the moment (machine in the States - me in the UK),
but looking at the check against a NULL local APIC address it will trap
the case on the reported box.

Mark

