Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132011AbRARKEI>; Thu, 18 Jan 2001 05:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRARKD6>; Thu, 18 Jan 2001 05:03:58 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:62468 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S132011AbRARKDo> convert rfc822-to-8bit; Thu, 18 Jan 2001 05:03:44 -0500
Date: Thu, 18 Jan 2001 11:02:19 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: Joel Franco Guzmán <joel@gds-corp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>
Message-ID: <Pine.HPX.4.10.10101181050260.3561-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Joel Franco Guzmán wrote:

> With 128M the problem is not present, but with 192M it is. The only
> difference is the memory quantity, or in other words, the additional slot
> occupied by the new memory card.

>    - ASUS P299 (Chipset i440ZX). Note: the i440ZX don't support officially
> the coppermine processor at 133Mhz FSB.

I know that increasing the number of DIMMs on your board will require
speedier RAMs on ASUS boards with some sort of an i440 chipset. This may
well be the case for just about every other MB, it's only that I don't
know specifically about these other boards.

133MHz is damn fast, and you need really good RAMs to keep up to that.
In fact, most of the cheap modules sold as "PC133" can't cope with it,
and you just got PC100. That's asking for trouble! As you add more
modules, it gets even more critical.

Do extensive testing before actually using such a system. The best testing
that I know of is compiling large source trees with 2.2.x (I don't know
about 2.4.x -- I DO know that 2.0.x won't turn up problems as easily
because the buffer cache grows out of bounds) for hours and hours (10h
minimum, 48h or more desirable). Make sure that there is enough "free"
memory at all time (not cached, but really "free"). Also make sure that
the temperature inside your computer is slightly higher than in actual use
to put maximum stress on the RAMs.

You may be able to get away by just increasing the SDRAM timings if you
are running 2-2-2.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
