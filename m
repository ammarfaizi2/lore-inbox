Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRBIQgu>; Fri, 9 Feb 2001 11:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129978AbRBIQgk>; Fri, 9 Feb 2001 11:36:40 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:9989 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129667AbRBIQgf>;
	Fri, 9 Feb 2001 11:36:35 -0500
Date: Fri, 9 Feb 2001 17:36:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, gandalf@winds.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
Message-ID: <20010209173600.A2887@suse.cz>
In-Reply-To: <1500B3C52526@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1500B3C52526@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, Feb 09, 2001 at 05:29:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 05:29:52PM +0000, Petr Vandrovec wrote:

> > Unfortunately the PCI speed measuring code needs help from the chipset
> > itself, so it isn't possible to implement in generic code. Maybe a
> > callback could be added to the chipset-specific drivers, though ...
> > 
> > I do have some plans with ide-pci.c, so ...
> 
> Is not PCI speed determined by host-bridge setting (and not by IDE 
> interface)?

I found no way of measuring the PCI speed than by doing an IDE PIO
transfer unfortunately. Measuring all other PCI transactions gives bad
results, because it is dependent on waitstates and other variables.

> In that case we should determine bus speed on PCI bus scan 
> using chipset specific drivers. Other non IDE devices, such as matroxfb, 
> may be interested in PCI speed too.

Not the case, sorry. An IDE drive is needed. However, it still might be
worth to pass the PCI speed to other drivers ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
