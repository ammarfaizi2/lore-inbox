Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRLVWyB>; Sat, 22 Dec 2001 17:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbRLVWxv>; Sat, 22 Dec 2001 17:53:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282898AbRLVWxp>; Sat, 22 Dec 2001 17:53:45 -0500
Subject: Re: affinity and tasklets...
To: ashokr2@attbi.com (Ashok Raj)
Date: Sat, 22 Dec 2001 23:03:47 +0000 (GMT)
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <PPENJLMFIMGBGDDHEPBBIEKFCAAA.ashokr2@attbi.com> from "Ashok Raj" at Dec 22, 2001 09:16:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HvBD-0005af-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i.e in our devices, a single interrupt from our device indicates several
> device virtual interrupts, so even if i have several tasklets for each
> virtual device interrupts, the code that runs the real intr and schedules
> tasklets will end up queueing all of them on a single cpu.

Why do you care. Unless your interrupt event handling code is seriously slow
surely you want to run the things serially, efficiently and while the cache
is hot ?
