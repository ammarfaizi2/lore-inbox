Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSCGTNc>; Thu, 7 Mar 2002 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310467AbSCGTNX>; Thu, 7 Mar 2002 14:13:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22034 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310462AbSCGTNP>; Thu, 7 Mar 2002 14:13:15 -0500
Subject: Re: FPU precision & signal handlers (bug?)
To: paubert@iram.es (Gabriel Paubert)
Date: Thu, 7 Mar 2002 19:25:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203071820450.17751-100000@gra-lx1.iram.es> from "Gabriel Paubert" at Mar 07, 2002 06:31:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j3Vx-0003K5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree with the second part, but actually what you want is to start with
> an empty stack. Whether the contents are FP or MMX is irrelevant.
> Actually the support of applications using MMX did not require any change
> to the kernel (Intel carefully designed it that way).

Not the case. If you drop into a signal or exception handler and it uses
FPU while MMX is on it'll get a nasty shock. As it happens Linux already
did the right thing.

Intel minimised it and did pretty much the best job that could be done for
it
