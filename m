Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCLTex>; Mon, 12 Mar 2001 14:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRCLTeo>; Mon, 12 Mar 2001 14:34:44 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57604
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129749AbRCLTe1>; Mon, 12 Mar 2001 14:34:27 -0500
Date: Mon, 12 Mar 2001 11:33:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Daniela Engert <dani@ngrt.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
In-Reply-To: <20010309085303.A690@suse.cz>
Message-ID: <Pine.LNX.4.10.10103121133240.2883-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniela,

Great to hear from you again my dear! ;-)

On Fri, 9 Mar 2001, Vojtech Pavlik wrote:

> On Fri, Mar 09, 2001 at 08:25:43AM +0100, Daniela Engert wrote:
> 
> > >They're about the same - only Alan didn't like the PCI speed measurement
> > >code that's new in the 4.x series, so I added all the other changes to
> > >the 3.20 driver, and 3.21 was born.
> > 
> > I do understand Alan's objections against this speed measurement code
> > very well. I have similar code built into other (non-Linux) drivers,
> > and according to the many user reports that I got the measurement
> > results should be taken with a grain of salt. It is working perfectly
> > in most cases, but it may fail from time to time. There is a hidden
> > assumption in this type of measurement which the device that you run
> > the test against has to fulfill. If it doesn't (and it is not required
> > to do to be conforming to the ATA spec), the measurement results (PCI
> > bus clock) are bogus (typically way too high).
> 
> Actually I don't think my method can ever result in a measurement higher
> than real PCI clock, but can result in a lower one (if the device
> deasserts IORDY even on a speed slower than PIO_0), which is also a
> problem. Anyway, on fast machines the accuracy of the current algorithm
> is +- .01 MHz.
> 
> Once tested a little more, the measurement will probably go in, however
> with an option for the user to override it with a command line
> parameter.
> 
> Btw, if it isn't a secret - what other drivers are those and what is the
> exact method you used ... ?
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

