Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270228AbRHGXew>; Tue, 7 Aug 2001 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270237AbRHGXen>; Tue, 7 Aug 2001 19:34:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270228AbRHGXef>; Tue, 7 Aug 2001 19:34:35 -0400
Subject: Re: Via chipset
To: oyhaare@online.no (=?ISO-8859-1?Q?=D8ystein?= Haare)
Date: Wed, 8 Aug 2001 00:36:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997225828.10528.4.camel@eagle> from "=?ISO-8859-1?Q?=D8ystein?= Haare" at Aug 08, 2001 01:10:28 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UGOw-0004H2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm planning on getting a new workstation, and I kinda want an AMD
> system. But it seems that most (all?) motherboards for the amd cpu's us=
> e
> VIA chipsets, and some people have experienced problems with via
> chipsets and linux.

We have seen two big problem sets with the VIA chipsets and Athlon. The
first is a bug in some of the bridges that caused corruption. We had partial
workarounds but as of 2.4.7ac releases (and I sent it to Linus for
2.4.8pre) we have an official workaround based on VIA provided info.

The second problem is that some VIA chipset boards lock up running the
Athlon optimised kernel. This seems to be board specific and we've also had
'setting CAS3 not CAS2' and 'bigger PSU' reports of fixing it for some
people. I'm still trying to put together a detailed enough study of what
is going on to actually take it to VIA and AMD engineers.

So pick a board other folks say work. Personally I am using AMD chipset
boards but I don't think thats actually a required solution to avoid the
problem. 

As to the PIV. Right now I see no reason to go that way. The PIV is going to
need new compiler tools to get good performance at the moment. It also
requires rambus memory. The rambus memory requirement will change soon, the
processor will go down to a smaller die size (0.13u) and should get both
cheaper and cooler. Hopefully intel will also fix the performance problems
with the extra silicon space they will get out of it.

So if you think PIV wait for the new socket, new die size then study reviews
IMHO.

Alan
