Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288880AbSAERPN>; Sat, 5 Jan 2002 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288881AbSAEROx>; Sat, 5 Jan 2002 12:14:53 -0500
Received: from ns.suse.de ([213.95.15.193]:44549 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288880AbSAEROn>;
	Sat, 5 Jan 2002 12:14:43 -0500
Date: Sat, 5 Jan 2002 18:14:42 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Paul Jakma <paulj@alphyra.ie>
Cc: <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201051659040.15928-100000@dunlop.dub.ie.alphyra.com>
Message-ID: <Pine.LNX.4.33.0201051807160.27113-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Paul Jakma wrote:

> how does devicefs differ from devfs? eg, on some of my systems i mount
> devfs on /devfs and an ls -l of it shows all the devices that
> currently have drivers that registered them.

different goals. One of the reasons this has come about is for power
management, we need a tree like structure so that we for eg, power
down a network card before powering down the pci bridge it sits on.
(The idea being to power down from the leaves, and work your way back
up to the root of the tree)

devicefs is just a means of exporting this to userspace, be that for
usage with the userspace acpi tools, or for hinv like programs.
As I mentioned earlier, ACPI enumerates pretty much everything in the
system, even if theres no driver for it.
If there is a driver for it, it can register things like "I support
these power saving states" with driverfs for additional functionality.

It would be nice at some point to get some of the other (pre-ACPI)
busses registering stuff there too, for completeness.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

