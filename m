Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131740AbRCXSKC>; Sat, 24 Mar 2001 13:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131741AbRCXSJx>; Sat, 24 Mar 2001 13:09:53 -0500
Received: from front6.grolier.fr ([194.158.96.56]:45973 "EHLO
	front6.grolier.fr") by vger.kernel.org with ESMTP
	id <S131740AbRCXSJj> convert rfc822-to-8bit; Sat, 24 Mar 2001 13:09:39 -0500
Date: Sat, 24 Mar 2001 16:58:14 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
In-Reply-To: <3ABCD0B2.21465AC1@sgi.com>
Message-ID: <Pine.LNX.4.10.10103241647530.601-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Mar 2001, LA Walsh wrote:

> I have a machine with 3 of these controllers (a 4 CPU server).  The
> 3 controllers are:
> ncr53c810a-0: rev=0x23, base=0xfa101000, io_port=0x2000, irq=58
> ncr53c810a-0: ID 7, Fast-10, Parity Checking
> ncr53c896-1: rev=0x01, base=0xfe004000, io_port=0x3000, irq=57
> ncr53c896-1: ID 7, Fast-40, Parity Checking
> ncr53c896-2: rev=0x01, base=0xfe004400, io_port=0x3400, irq=56
> ncr53c896-2: ID 7, Fast-40, Parity Checking
> ncr53c896-2: on-chip RAM at 0xfe002000
> 
> I'd like to be able to make a kernel with the driver compiled in and
> no loadable module support.  It don't see how to do this from the
> documentation -- it seems to require a separate module loaded for
> each controller.  When I compile it in, it only see the 1st controller
> and the boot partition I think is on the 3rd.  Any ideas?

The driver tries to detect all controllers it supports. Since the
ncr53c8xx supports both the 810a and the 896, all your controllers should
have been detected. When loaded as a module, the driver must be loaded
once (btw, a seconf load should fail).

> This problem is present in the 2.2.x series as well as 2.4.x (x up to 2).

What hardware are you using (CPU, Core Logic and tutti quanti) ?
Is the 896 on PCI BUS #0 or on some sort of secondary PCI BUS ?
Does the sym53c8xx driver show same behaviour ?

  Gérard.

