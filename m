Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRBSWIb>; Mon, 19 Feb 2001 17:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129457AbRBSWIU>; Mon, 19 Feb 2001 17:08:20 -0500
Received: from slc868.modem.xmission.com ([166.70.6.106]:7690 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129468AbRBSWIQ>; Mon, 19 Feb 2001 17:08:16 -0500
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
Cc: Jaswinder Singh <jaswinder.singh@3disystems.com>, peterw@dascom.com.au,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel executation from ROM
In-Reply-To: <XFMail.20010219124909.peterw@dascom.com.au> <01e701c09a2a$21e789a0$bba6b3d0@Toshiba> <3A914E57.9990EB7C@sympatico.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Feb 2001 12:50:34 -0700
In-Reply-To: Jeremy Jackson's message of "Mon, 19 Feb 2001 11:48:23 -0500"
Message-ID: <m1snlazc39.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:

> Jaswinder Singh wrote:
> 
> > Dear Sirs,
> >
> > Thanks for your help,
> >
> > I see . The biggest negative point of running kernel from ROM is that ROM
> > speed is slow :(
> 
> Also, the PCI specification forbids executing code from ROMs over the PCI bus.
> The system BIOS in a PC is not on the PCI bus, bus, but everything else is.

No it forbids executing boot roms that way, by a standard pc bios.  
The system BIOS in a PC is normally on the ISA bus which is reached
across via the PCI bus with a PCI->ISA bridge.

The thing is slow it really doesn't matter, all you need to do is
enable caching on that area of the physical address space.  You can't
do this on the alpha currently but only because the alpha sucks that
way.  You can on practically everything else.

As for ROM being slow on x86 you can enable the MTRR to speed things
up.  Usually though ROMs are at least as expensive as RAM, so it is
pointless.

Eric
