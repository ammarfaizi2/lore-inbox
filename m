Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbREEFoS>; Sat, 5 May 2001 01:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbREEFoH>; Sat, 5 May 2001 01:44:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8561 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132553AbREEFnz>; Sat, 5 May 2001 01:43:55 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <E14vj0V-0007ek-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 23:41:39 -0600
In-Reply-To: Alan Cox's message of "Fri, 4 May 2001 18:04:40 +0100 (BST)"
Message-ID: <m1u230mjxo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Seriously.  With the general attitude of distrusting BIOS's I have
> > been amazed at the number of things linux expects the BIOS to get
> > right.  In practice windows seem to trust the BIOS much less than
> > linux does.
> 
> It becomes more and more obvious over time exactly why. One problem however
> is that windows gets away with this because many vendors ship random extra
> gunge for their box with the system. We dont yet have that power

Right.  So we always need to keep heuristics in our toolbox to fallback on,
so we can run on boards with incomplete information.  However there is a lot
of things we can do that we aren't currently doing.

The example that sticks out in my head is we rely on the MP table to
tell us if the local apic is in pic_mode or in virtual wire mode.
When all we really have to do is ask it.

Eric

