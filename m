Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289456AbSA1UYQ>; Mon, 28 Jan 2002 15:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSA1UWW>; Mon, 28 Jan 2002 15:22:22 -0500
Received: from mailf.telia.com ([194.22.194.25]:7907 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S289369AbSA1UVT>;
	Mon, 28 Jan 2002 15:21:19 -0500
Message-Id: <200201282021.g0SKL2p07886@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Pavel Machek <pavel@ucw.cz>, alan@lxorguk.ukuu.org.uk
Subject: Re: preempt & ne2k
Date: Mon, 28 Jan 2002 21:18:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020127215253.A793@elf.ucw.cz>
In-Reply-To: <20020127215253.A793@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday den 27 January 2002 21.52, Pavel Machek wrote:
> Hi!
>
> > > testing the patch complaining about, AND one that seems like it could
> > > be addressed by using IRQ disabling as a latency guard in addition to
> > > spinlocks.
> >
> > I dont believe anyone has tested the driver hard with pre-empt. Its not
> > that this driver can't be fixed. Its that this is one tiny example of
> > maybe thousands of other similar flaws lurking. There is no obvious
> > automated way to find them either.
>
> So.... you have shown performance problem in one driver. Maybe *bad*
> performance problem, but only performance problem. There may be other
> performance problems out there. And what?
> 								Pavel

In Alans example it is not a performance problem - it is more of a 
correctness problem.

The case when a driver were disabling a specific interrupt was not handled
in a 100% correct way.

There are some other cases that might be even harder to detect - disabling
from a device by writing in its control register.

But if the preempt patch is added those critical sections can be protected.

It is not trivial nor impossible...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
