Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131736AbRBMOmL>; Tue, 13 Feb 2001 09:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbRBMOmB>; Tue, 13 Feb 2001 09:42:01 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:12719 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S131736AbRBMOls>; Tue, 13 Feb 2001 09:41:48 -0500
Date: Tue, 13 Feb 2001 15:41:37 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org, Dan.Zink@compaq.com
Subject: Re: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
Message-ID: <20010213154137.A19612@inf.tu-dresden.de>
In-Reply-To: <20010212140419.A11619@lug-owl.de> <20010213003815.A17962@inf.tu-dresden.de> <20010213122013.A31590@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213122013.A31590@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Feb 13, 2001 at 12:20:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Feb 13, 2001 at 12:20:14 +0100, Jan-Benedict Glaw wrote:
> On Tue, Feb 13, 2001 at 12:38:15AM +0100, Adam Lackorzynski wrote:
> > On Mon Feb 12, 2001 at 14:04:20 +0100, Jan-Benedict Glaw wrote:
> > > I've got a "Bull Express5800/Series" (dual P3) with a DAC1164 RAID
> > > controller. The mainboard is ServerWorks based and however, 2.4.2-pre3
> > > fails to find the RAID controller. I think there's a problem at
> > > scanning PCI busses behind PCI bridges. Here's the PCI bus layout as
> > > 2.4.0-test10 recognizes it:
> > 
> > --- pci-pc.c.orig       Tue Feb 13 00:02:50 2001
> > +++ pci-pc.c    Tue Feb 13 00:19:29 2001
> > @@ -953,9 +953,6 @@
> [Removal of serverworks fixup routines]
> 
> That patch cured the problem; the box is up'n'running again. Thanks!

Ok, fine.

Since this patch works for Jan, Dan and me I'd suggest putting it into
the kernel and thus removing the fixup routines (Anyone know the reason
why they're there?).

Comments?!


Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
