Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268320AbRGZQcF>; Thu, 26 Jul 2001 12:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRGZQb4>; Thu, 26 Jul 2001 12:31:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16779 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S268320AbRGZQbn>;
	Thu, 26 Jul 2001 12:31:43 -0400
Message-ID: <3B604612.F5FCC8E7@mandrakesoft.com>
Date: Thu, 26 Jul 2001 12:32:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: john@vnet.ibm.com, LINUX-KERNEL@vger.kernel.org
Subject: Re: Reserving large amounts of RAM for busmastering PCI card.
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com> <200107252200.f6PM0IJ01020@devserv.devel.redhat.com> <3B5F428F.14DCAA44@mandrakesoft.com> <20010726082925.B2322@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Pete Zaitcev wrote:
> 
> > > >  Since the 2.4 kernels introduce the e820map structure, I'd like to
> > > >  plug into that infrastructure, and create a new type memory segment
> > > >  for this storage (I envisage having more than one segment), but in the
> > > >  2.4.4 kernel (which I am forced to remain with for quite a while) it
> > > >  seems not to be used apart from set up at boot time.
> > >
> > > Stop reinventing the wheel and take Matt & Pauline's bigphisarea.
> > >  http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz
> >
> > Is bigphysarea needed in 2.4?   You have alloc_bootmem...
> 
> I thought bigphisarea allowed to unload and reload modules,
> at least I used it that way with C-cube MPEG board. Makes
> for faster tests.

AFAICS this is only useful to developers, not end users, yes?

Memory will get fragmented if done at some time other than boot, so
module loads will randomly fail based on conditions unrelated to the
module at hand.  It's not a reliable operation, as a module...

-- 
Jeff Garzik      | "I use Mandrake Linux for the same reason I turn
Building 1024    |  the light switch on and off 17 times before leaving
MandrakeSoft     |  the room.... If I don't my family will die."
                 |            -- slashdot.org comment
