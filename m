Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132675AbRDGQa1>; Sat, 7 Apr 2001 12:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132677AbRDGQaI>; Sat, 7 Apr 2001 12:30:08 -0400
Received: from front5.grolier.fr ([194.158.96.55]:33957 "EHLO
	front5.grolier.fr") by vger.kernel.org with ESMTP
	id <S132675AbRDGQ37> convert rfc822-to-8bit; Sat, 7 Apr 2001 12:29:59 -0400
Date: Sat, 7 Apr 2001 15:18:37 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Michael Reinelt <reinelt@eunet.at>
cc: Tim Waugh <twaugh@redhat.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACF1ED6.6B1D2D96@eunet.at>
Message-ID: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Apr 2001, Michael Reinelt wrote:

> Tim Waugh wrote:
> > 
> > On Sat, Apr 07, 2001 at 01:33:25PM +0200, Michael Reinelt wrote:
> > 
> > > Adding PCI entries to both serial.c and parport_pc.c was that easy....
> > 
> > And that's how it should be, IMHO.  There needs to be provision for
> > more than one driver to be able to talk to any given PCI device.
> 
> True, true, true.

Could you start up your brain now :) and think about the actual issue. All
the drivers must share the device resources and there is no (simple) way
to do so generically.
What you want to do is to write a single software driver, optionnaly
broken into several modules, that is aware of all the functionnalities of
the board and that will register to all involved sub-systems as needed.

> But - how to deal with it? Who decides if we can deal this way or not?
> PCI maintainer? Linus?
> 
> bye, Michael
> 
> P.S. I really need this. I have to unload serial and parallel and reload
> them in different order when I want either print something or talk to my
> Palm :-(

What about the option of using a different hardware ? :-)

  Gérard.

