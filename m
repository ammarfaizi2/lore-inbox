Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282878AbRK0I5z>; Tue, 27 Nov 2001 03:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282880AbRK0I5p>; Tue, 27 Nov 2001 03:57:45 -0500
Received: from bartok.tm.edu.ro ([193.226.8.238]:18845 "EHLO bartok.tm.edu.ro")
	by vger.kernel.org with ESMTP id <S282878AbRK0I5h>;
	Tue, 27 Nov 2001 03:57:37 -0500
Date: Mon, 26 Nov 2001 20:04:34 +0200 (EET)
From: Valkai Elod <elod@bartok.tm.edu.ro>
To: Mark Hymers <markh@linuxfromscratch.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I add a drive to the DMA blacklist?
In-Reply-To: <20011126002257.A507@markcomp.blaydon.hymers.org.uk>
Message-ID: <Pine.LNX.4.33.0111262001290.13196-100000@bartok.tm.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Mark Hymers wrote:

> On Sun, 25, Nov, 2001 at 06:17:08PM -0500, Jonathan Kamens spoke thus..
> > How do I get a drive added to the DMA blacklists in ide-dma.c?  I sent
> > E-mail to Andre Hedrick in August about a drive that claims to support
> > DMA but flakes out as soon as the kernel tries to use it -- the "WDC
> > AC31000H".  This is not surprising, since all the other WDC drives of
> > this vintage have the same problem.  I included a patch to add this
> > drive to the two blacklists in ide-dma.c.  Andre never responded to my
> > E-mail, and the drive still hasn't been added to the blacklists.
> >
> > Am I doing something wrong?  What do I need to do to get this drive
> > added to the blacklists?
> Actually, while this subject is being brought up, if I don't do:
> /sbin/hdparm -d0 /dev/hdc
> on bootup, my system locks up randomly.  Looks like a DMA issue with my
> hdc drive.. Details are:
>
> /proc/ide/hdc/model:
> QUANTUM FIREBALLlct08 26

This seems to confirm my doubts about Quantum lct drives' sanity. I'm
having two drives: a Quantum CX 13G, and a Maxtor 40G@5400. Both work with
UDMA33 (mb doesn't support more). When i put a QUANTUM FIREBALL lct20 20G
drive in my rack, random lockups occur. I'd put all Quantum LCT drives on
the blacklist!

-- 

========================.~.===============================================
Elod VALKAI             /V\               "Linux is like a wigwam -
elod@bartok.tm.edu.ro  // \\                no windows, no gates,
                      /(   )\                  apache inside!"
==netadmin@bartok===== ^`~'^ ==---phone:(+40)56 221273 (195913-home)---===

