Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbSAMPxT>; Sun, 13 Jan 2002 10:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAMPxJ>; Sun, 13 Jan 2002 10:53:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49927 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286316AbSAMPw5>; Sun, 13 Jan 2002 10:52:57 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sun, 13 Jan 2002 15:59:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <1010891457.3561.18.camel@phantasy> from "Robert Love" at Jan 12, 2002 10:10:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pn2o-0007I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I disable a single specific interrupt, I don't disable the timer interrupt.
> > Your code doesn't seem to handle that.
> 
> It can if we increment the preempt_count in disable_irq_nosync and
> decrement it on enable_irq.

A driver that knows about how its irq is handled and that it is sole
user (eg ISA) may and some do leave it disabled for hours at a time
