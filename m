Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSFEHkJ>; Wed, 5 Jun 2002 03:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFEHjG>; Wed, 5 Jun 2002 03:39:06 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:19915 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S313416AbSFEHiZ>; Wed, 5 Jun 2002 03:38:25 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Pavel Machek'" <pavel@suse.cz>
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Date: Wed, 5 Jun 2002 11:34:23 +1000
User-Agent: KMail/1.4.5
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED5@orsmsx111.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206051134.24063.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 06:59, Grover, Andrew wrote:
> > > "Power management options (ACPI, APM)", which also includes
> >
> > software suspend.
> >
> > > "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> > > "Executable file formats"
>
> Brad,
>
> This is a tough one because ACPI *is* power management but it is also
> configuration. It is equivalent to such things as MPS table parsing, $PIR
> parsing, PNPBIOS, as well as APM. The first two don't have CONFIG_ options
> at the moment but they should at some point.
>
> The only thing I can think of is a "Platform interface options" menu and
> just throw all of the above in that. Any other ideas?
"Platform interface" is fairly true, but so was "general options". Neither of 
them is an obvious description of the functionality.

One idea that comes to mind is putting the power management config options in 
a "Power Management" section, then PNPBIOS in with the other PnP stuff, and 
so on (read: don't know were to put MPS yet, and don't know what $PIR is :) I 
understand that this means breaking up the ACPI config file, but that 
shouldn't be too hard. 

The general concept is that [c,C]onfig.in should be functionality based, not 
implementation based. ACPI parsing isn't a function, it supports a whole 
range of functions, which are quite different to the user.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
