Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132084AbRAXNWL>; Wed, 24 Jan 2001 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRAXNWB>; Wed, 24 Jan 2001 08:22:01 -0500
Received: from zmamail02.zma.compaq.com ([161.114.64.102]:23557 "HELO
	zmamail02.zma.compaq.com") by vger.kernel.org with SMTP
	id <S132084AbRAXNVr>; Wed, 24 Jan 2001 08:21:47 -0500
Message-ID: <3A6ED741.CACC619C@zk3.dec.com>
Date: Wed, 24 Jan 2001 08:23:13 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg from Systems <chandler@d2.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Big Bada Boom...
In-Reply-To: <Pine.SGI.4.10.10101231316420.29904-100000@hell.d2.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I've been bitten by this quite often.  Basically, just edit arch/alpha/kernel/Makefile and remove irq_pyxis.c from the obj-y
line.  I'm not positive what systems require it exactly, but rawhide isn't one of them.  I have a totally separate patch from Andrea
that suggests (to my mind) that it is required for: GENERIC, CIA, CABRIOLET, EV164, EB66P, LX164, PC164, MIATA, RUFFIAN and SX164.  Does
someone want to verify that and then a quickie patch can be whipped up and sent in.

 - Pete

Greg from Systems wrote:

> 2.4.0 Kernel problem...
> Alpha version only..
>
> This seems to be purely a source problem...
>
> attached is my .config, and here is the problem:
>
> when using the attached .config and running a 'make dep ; make boot' I get
> the following:
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
