Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRIARMu>; Sat, 1 Sep 2001 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270827AbRIARMl>; Sat, 1 Sep 2001 13:12:41 -0400
Received: from tantalophile.demon.co.uk ([193.237.65.219]:3200 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S270818AbRIARMc>; Sat, 1 Sep 2001 13:12:32 -0400
Date: Sat, 1 Sep 2001 16:50:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Russell Coker'" <russell@coker.com.au>,
        "\"Acpi-linux (E-mail)\"" <acpi@phobos.fachschaften.tu-muenchen.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
Message-ID: <20010901165042.B1624@thefinal.cern.ch>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0DB@orsmsx35.jf.intel.com> <E15cx6w-00049f-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15cx6w-00049f-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Aug 31, 2001 at 11:50:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> All the discussion we have has been based on seriously enhancing and
> expanding the use of the initrd/ramfs layer. Remember we can begin running
> from ramfs without interrupts, pci bus scans or the like. The things it cant
> do are - pick a kernel by processor type, pick SMP/non SMP.

The kernel could be chosen by processor type, if you added a "reboot
into a new kernel" function.

It would be rather large for one initramfs, as _all_ of the modules have
combinations of SMP/non-SMP x i386/486/586/686/athlon/686-PAE versions,
not just the core kernel.

It may still be a useful function for CDROM or network boots though.
I.e. initramfs selects an optimised kernel and set of modules to run,
and replaces the current generic kernel with the optimised one.

-- Jamie
