Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282498AbRLFTKn>; Thu, 6 Dec 2001 14:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRLFTKe>; Thu, 6 Dec 2001 14:10:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282498AbRLFTKb>; Thu, 6 Dec 2001 14:10:31 -0500
Subject: Re: Linux/Pro  -- clusters
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 6 Dec 2001 19:19:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112061044150.10877-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 06, 2001 10:55:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C43U-0002in-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Normal read/write is TCP - we do merging, sorting, re-ordering etc, again
> at a higher level. The packet that makes it to the low-level driver is
> just a packet. This is the only layer that does retransmit etc.

Makes sense yes. I'm not sure how much we can push into user space before
we break back compatibility or lose the needed info/security credentials
to take action but it makes sense when possible.

> > For those of us who want to run a standards based operating system can
> > you do the 32bit dev_t.
> 
> You asked for an _internal_ data structure. dev_t is the external
> representation, and has _nothing_ to do with any drivers at all.

The internal representation is kdev_t, which wants to turn into a pointer
from what Aeb has been saying for a long time. A 32bit "dev_t" is need so
that we can label over 65536 file systems to things like ls, regardless of how
"/dev/sdfoo" is mapped onto a driver

I'm sure that dev_t (the cookie we feed to user space) going to 32bits is
going to break something and I'd rather it broke early

Alan

