Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313136AbSC1Lh4>; Thu, 28 Mar 2002 06:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSC1Lhr>; Thu, 28 Mar 2002 06:37:47 -0500
Received: from vaak.stack.nl ([131.155.140.140]:9228 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S313136AbSC1Lhh>;
	Thu, 28 Mar 2002 06:37:37 -0500
Date: Thu, 28 Mar 2002 12:37:36 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <3CA25A1A.31572.2DCF314@localhost>
Message-ID: <20020328120105.C89160-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To get everything clear, regarding the hot-swapping laptops:

ATA is the standard that tells how to communicate with a harddisk. You
just can stop communicating, easy as it is. Finish the last command like
ATA says you to, and the communication is idle.

IDE is one implementation of the communication channel. This specific
implementation is not designed with hot swappable capabilities in mind.

Laptops use their own communication channel. As long as the channel is
capable of communicating ATA-compatible, the designer is free in designing
this channel. So, designers are free to implement neat tristate buffers,
real powerdown modes in their harddisks, etcetera. Usually, to prevent
problems, these communication channels present theirselves to the outer
world as generic IDE compliant.

Maybe a clear example is the Serial-ATA bus (www.serialata.com). This is a
serial communication channel for ATA communication. This channel has
nothing to do with IDE anymore, but is still completely ATA compliant.

The problem is that ATA and IDE were just made for each other, so they are
mixed up many times. In fact, the part that is often called the IDE
driver, is actually the ATA driver. The IDE driver is the code that sets
up your chipset for Ultra-DMA etcetera.

Jos



