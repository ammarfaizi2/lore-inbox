Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSCHML7>; Fri, 8 Mar 2002 07:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310832AbSCHMLt>; Fri, 8 Mar 2002 07:11:49 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:62219 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S310823AbSCHMLh>;
	Fri, 8 Mar 2002 07:11:37 -0500
Date: Fri, 8 Mar 2002 13:11:22 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPU precision & signal handlers (bug?)
In-Reply-To: <E16j3Vx-0003K5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203081254130.22832-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Mar 2002, Alan Cox wrote:

> > I agree with the second part, but actually what you want is to start with
> > an empty stack. Whether the contents are FP or MMX is irrelevant.
> > Actually the support of applications using MMX did not require any change
> > to the kernel (Intel carefully designed it that way).
>
> Not the case. If you drop into a signal or exception handler and it uses
> FPU while MMX is on it'll get a nasty shock. As it happens Linux already
> did the right thing.

You are in for the same shock if you the FPU is in non MMX mode. Think of
the case when all stack entries are marked valid in the interrupted
process: stack overflow on the first fld.

Or alernatively show me how you could simplify the signal delivery FPU
logic for non MMX processor.

Answer: you can't. I still stand by my statement that MMX is
completely irrelevant and does not add any special case.

> Intel minimised it and did pretty much the best job that could be done for
> it.

Better than this, they made it completely transparent.

	Gabriel.

