Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290868AbSARXHI>; Fri, 18 Jan 2002 18:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290869AbSARXHE>; Fri, 18 Jan 2002 18:07:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30987 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290868AbSARXGp>; Fri, 18 Jan 2002 18:06:45 -0500
Subject: Re: [RFC] Summit interrupt routing patches
To: jamesclv@us.ibm.com
Date: Fri, 18 Jan 2002 23:15:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201182246.g0IMkbq10990@butler1.beaverton.ibm.com> from "James Cleverdon" at Jan 18, 2002 02:46:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RiEX-0008Bi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> alternative is much more invasive:  adding interrupt code to adjust XTPRs, 
> hacks to the scheduler to somehow encapsulate task priority in 4 bits, etc.

Is it necessary to try something complex. We already keep per cpu/per irq
data and if you have a lot of interrupts it feels like you can handwave them
to be roughly the same amount of cpu load. 

Given that is it enough to once a second shuffle the irqs around to try and
get a rough balance based on a simple decaying history. Then all it needs
is a regular timer event to do what the hardware hasnt

