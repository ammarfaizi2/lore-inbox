Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310918AbSCHQxr>; Fri, 8 Mar 2002 11:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310948AbSCHQx3>; Fri, 8 Mar 2002 11:53:29 -0500
Received: from pop.gmx.de ([213.165.64.20]:50272 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310918AbSCHQxQ>;
	Fri, 8 Mar 2002 11:53:16 -0500
Message-ID: <3C88EC6E.C59BC167@gmx.net>
Date: Fri, 08 Mar 2002 17:53:02 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <Pine.LNX.4.10.10203080831480.504-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> On Fri, 8 Mar 2002, Martin Dalecki wrote:
>
> > Luigi Genoni wrote:
> > > Due to a lack of time i tried just 2.5.5, which worked very well.
> > > I get the oops while initializing the IDE controller, just after
> > >
> > > hdc: LTN485, ATAPI CD/DVD-ROM drive
> > >
> > > and before the expected:
> > > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > >
> >
> > OK thank you very much this helps. I will actually have to fake the
> > detection on my system to think it's the same as yours...
> > One thing for sure: it's not dircetly inside the
> > PCI host initialization, so I wonder why this problem
> > doesn't occur to more people.
>
> You will soon learn about the way ATAPI removable media violate the rules
> of how the maintain their status and signal lines.  However you already
> knew this information as I am wasting electrons

Can you get more specific ?

Do you mean
a) Some ATAPI devices violate the "ATA/ATAPI-4" NCITS 317-1998 standard  (or
a newer version),
     And your driver contained workarounds for these buggy devices? (And
Martins driver doesn't contain these.)
b) Your driver conforms to the standard, and Martin's driver does not?



