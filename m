Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263546AbRFFQ0I>; Wed, 6 Jun 2001 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263540AbRFFQZ7>; Wed, 6 Jun 2001 12:25:59 -0400
Received: from sun.plan9.de ([213.69.218.222]:44959 "EHLO mailout.plan9.de")
	by vger.kernel.org with ESMTP id <S263546AbRFFQZo>;
	Wed, 6 Jun 2001 12:25:44 -0400
Date: Wed, 6 Jun 2001 18:24:36 +0200
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
Message-ID: <20010606182436.A9439@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Axel Thimm <Axel.Thimm@physik.fu-berlin.de>, Au-Ja <doelf@au-ja.de>,
	Yiping Chen <YipingChen@via.com.tw>, support@msi.com.tw,
	info@msi-computer.de, support@via-cyrix.de,
	John R Lenton <john@grulic.org.ar>
In-Reply-To: <20010519110721.A1415@pua.nirvana> <20010601171848.F467@cerebro.laendle> <3B17B4B0.9A805766@mandrakesoft.com> <20010601221637.B13797@cerebro.laendle> <3B1AB5BA.8060805@humboldt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3B1AB5BA.8060805@humboldt.co.uk>; from adrian@humboldt.co.uk on Sun, Jun 03, 2001 at 11:10:02PM +0100
X-Operating-System: Linux version 2.4.5 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 11:10:02PM +0100, Adrian Cox <adrian@humboldt.co.uk> wrote:
> > data corruption was easily detectable, one couldn't even write 500megs
> > without altered bytes).
> 
> 
> Wrong way round. You're right that the pci master is supposed to handle 
> delayed transactions, but during data transfer the pdc is the pci master 
> and the northbridge is the PCI target.

Ok, so it could be the promise controller (the controller, however, worked
for a long time in another board with no via chipset and pci delayed
transactions enabled, so I guess it is not only dependnet on the promise
controller).

and this means that there is no automatic workaround, since not all
systems seem to have this problem.

I *do* hate silent data corruption :()

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
