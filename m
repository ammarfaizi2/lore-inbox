Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDGTbh>; Sat, 7 Apr 2001 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRDGTb1>; Sat, 7 Apr 2001 15:31:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53937 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130487AbRDGTbP>;
	Sat, 7 Apr 2001 15:31:15 -0400
Message-ID: <3ACF6B02.3DE79321@mandrakesoft.com>
Date: Sat, 07 Apr 2001 15:31:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
Cc: Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <3ACEFB05.C9C0AB3C@eunet.at> <20010407131631.A3280@redhat.com> <3ACF4D0F.9D15EB7F@mandrakesoft.com> <20010407200856.E3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Sat, Apr 07, 2001 at 01:23:27PM -0400, Jeff Garzik wrote:
> 
> > You asked in your last message to show you code, here is a short
> > example.  Note that I would love to rip out the SUPERIO code in parport
> > and make it a separate driver like this short, contrived example.  Much
> > more modular than the existing solution.
> 
> (The superio code is on its way out anyway, for different reasons..)

I think there will be further discussion on this :)

> More modular?  Yes, it adds another module to support a card, so yes
> there are more modules.
> 
> But with the multifunction_quirks approach, support is a question of
> adding two lines in a table.

struct pci_driver is going to become struct driver, don't forget.  With
that in mind, the "multifunction_quirks" patch appears even more of a
bus-specific hack.

Why do you want to dirty the soon-to-be generic driver API for stupid
hardware?

It takes two seconds to write a shim driver as I have described, and
further a shim driver is not necessary on sensible hardware.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
