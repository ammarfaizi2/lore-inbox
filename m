Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRIAMkp>; Sat, 1 Sep 2001 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270640AbRIAMkg>; Sat, 1 Sep 2001 08:40:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270619AbRIAMk0>; Sat, 1 Sep 2001 08:40:26 -0400
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
To: pwaechtler@loewe-komp.de (Peter =?iso-8859-1?Q?W=E4chtler?=)
Date: Sat, 1 Sep 2001 13:39:10 +0100 (BST)
Cc: _deepfire@mail.ru (Samium Gromoff), linux-kernel@vger.kernel.org
In-Reply-To: <3B90CE7E.F4F54D9@loewe-komp.de> from "Peter =?iso-8859-1?Q?W=E4chtler?=" at Sep 01, 2001 02:03:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dA3K-0004uV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did someone any benchmarking?

Yes

> I expect the loss of performance per application a none issue.
> What do you think: >0.5%?

It depends on the actual application

> Are you considering interrupt latency in the first place?

IRQ latency isnt the issue. Older x86 processors have dreadful locking 
performance. On an Athlon or later pIII there seems to be very little
difference, but other stuff you can measure it.

Locks cost. On older CPU's atomic operations go back to main memory and on
newer processors they still cause pipeline stalls. Calling back to non
inlined locks has a small hit too.

> Then obviously BeOS is also engineered from idiots...
> Oh, and QNX/RTP has separate kernels for UP/SMP. And they
> don't need UP/SMP versions of "modules".

I doubt they were idiots. I suspect they had different engineering
constraints like "base system must fit on one floppy disk".

Alan
