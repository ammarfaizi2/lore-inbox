Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131659AbRDCMmU>; Tue, 3 Apr 2001 08:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131728AbRDCMmK>; Tue, 3 Apr 2001 08:42:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31237 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131659AbRDCMl5>; Tue, 3 Apr 2001 08:41:57 -0400
Subject: Re: Larger dev_t
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Tue, 3 Apr 2001 13:41:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl,
        torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <20010403142024.Z8155@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Apr 03, 2001 02:20:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kQ8D-000807-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Names stay constant, but why the NUMBERS? The names should stay
> constant and represent the actual layout on each busses (say:
> sane hierachic enumeration) of course.

You can do it that way too

> But /dev/ide/host0/bus0/target0/lun0/part1 could get a new device
> number on every reboot, right?

It could be a different device each boot too. Who is doing the bus
enumeration in a constant manner.

> Otherwise it would be too easy to remove static major/minors and
> all the fun allocating them. And LANANA would have one thing less
> to worry about ;-)

There are a very large number of reasons you need them and things that depend
on constant numbering for block devices such as backup tools. They can Im sure
be taught constant naming, but there is no provision for names not device ids
in them.

Things like tar will no longer work on Linux for example because tar does not
know how to archive the name of a device node.

> One thing I certainly miss: DevFS is not mandatory (yet).

devfs solves a different problem - enumeration of dynamically configured 
resources. Its unrelated to the fundamental problem.

