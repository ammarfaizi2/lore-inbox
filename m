Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312587AbSCVAwt>; Thu, 21 Mar 2002 19:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312586AbSCVAwi>; Thu, 21 Mar 2002 19:52:38 -0500
Received: from zarzycki.org ([216.218.222.115]:26524 "EHLO zarzycki.org")
	by vger.kernel.org with ESMTP id <S312587AbSCVAwV>;
	Thu, 21 Mar 2002 19:52:21 -0500
Date: Thu, 21 Mar 2002 16:47:10 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Langford <jcl@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <E16oAs1-0006SJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203211626410.3631-100000@tidus.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Alan Cox wrote:

> > There seems to be some fundamental incompatibility between the kernel
> > and the IDE chipset.  On several kernels in the 2.4 series including
> > 2.4.18, I observe a hang in the bootsequence at:
> > 
> > ALI15X3: IDE controller on PCI bus 00 dev 78
> > PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
> > ALI15X3: chipset revision 195
> > ALI15X3: not 100% native mode: will probe irqs later
> > <hang>
> 
> And does pci=bios help ?

Nope. Neither does pci=biosirq.

I'm seeing the same problem on the Sony Vaio PictureBook C1MV/M.

Disabling the ALI 15X3 driver avoids the problem for me. If I can find 
some free time, I'm going to start adding printf()s to see where things 
are hanging...

davez

-- 
Dave Zarzycki
http://zarzycki.org/~dave/

