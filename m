Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271572AbRIDPLc>; Tue, 4 Sep 2001 11:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271652AbRIDPLO>; Tue, 4 Sep 2001 11:11:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271572AbRIDPK6>; Tue, 4 Sep 2001 11:10:58 -0400
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
To: rastos@woctni.sk
Date: Tue, 4 Sep 2001 16:15:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010904145710.rastos@woctni.sk> from "Rastislav Stanik" at Sep 04, 2001 02:57:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eHup-0003ir-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The moving parts of the plotter are controlled by ISA card that generates
> (and responds to) interrupts on each movement or printing event.
> The interrupts can be generated quite fast; up to frequency of 4kHz.

Thats fine. The issue you might need to consider is how long you can wait
between an irq and actually excuting the handler. If that is very tight then
you may want Victor Yodaiken's rtlinux
