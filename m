Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSCHRId>; Fri, 8 Mar 2002 12:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310954AbSCHRIX>; Fri, 8 Mar 2002 12:08:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32516
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310953AbSCHRIM>; Fri, 8 Mar 2002 12:08:12 -0500
Date: Fri, 8 Mar 2002 09:07:47 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <3C88EC6E.C59BC167@gmx.net>
Message-ID: <Pine.LNX.4.10.10203080904470.504-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Gunther Mayer wrote:

> Andre Hedrick wrote:
> 
> > On Fri, 8 Mar 2002, Martin Dalecki wrote:
> >
> > > Luigi Genoni wrote:
> > > > Due to a lack of time i tried just 2.5.5, which worked very well.
> > > > I get the oops while initializing the IDE controller, just after
> > > >
> > > > hdc: LTN485, ATAPI CD/DVD-ROM drive
> > > >
> > > > and before the expected:
> > > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > >
> > >
> > > OK thank you very much this helps. I will actually have to fake the
> > > detection on my system to think it's the same as yours...
> > > One thing for sure: it's not dircetly inside the
> > > PCI host initialization, so I wonder why this problem
> > > doesn't occur to more people.
> >
> > You will soon learn about the way ATAPI removable media violate the rules
> > of how the maintain their status and signal lines.  However you already
> > knew this information as I am wasting electrons
> 
> Can you get more specific ?
> 
> Do you mean
> a) Some ATAPI devices violate the "ATA/ATAPI-4" NCITS 317-1998 standard  (or
> a newer version),

Few conform to "ATA/ATAPI-4" NCITS 317-1998 standard" or newer

>      And your driver contained workarounds for these buggy devices? (And
> Martins driver doesn't contain these.)
> b) Your driver conforms to the standard, and Martin's driver does not?

It may look like a simple protocol, and it is once you understand it and
all the nasties done to it by the ATAPI folks. 

I do not know because I am working on making the ATA/ATAPI transport work
correctly in 2.4 and will release something in 2.6.

Regards,

Andre Hedrick
The Second Linux X-IDE guy


