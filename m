Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbRGCTIh>; Tue, 3 Jul 2001 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265918AbRGCTI1>; Tue, 3 Jul 2001 15:08:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265894AbRGCTIK>; Tue, 3 Jul 2001 15:08:10 -0400
Subject: Re: ACPI fundamental locking problems
To: andrew.grover@intel.com (Grover, Andrew)
Date: Tue, 3 Jul 2001 20:08:12 +0100 (BST)
Cc: jgarzik@mandrakesoft.com ('Jeff Garzik'),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds),
        acpi@phobos.fachschaften.tu-muenchen.de ("Acpi-linux (E-mail)")
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF2B@orsmsx35.jf.intel.com> from "Grover, Andrew" at Jul 03, 2001 11:54:39 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HVWu-0008Ck-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We're depending on vendors (aka the BIOS) for all the ACPI tables, as well
> as every other piece of a priori data we need to boot the OS.

They have had enough problems getting simpler API's right. The ACPI spec is
bloated, complex, and very hard to follow - and its written in my native
language. I really do not envy a random BIOS writers task.

> Could I please ask that you at least show me a system where this is a
> problem before throwing out all the work we've done on ACPI because of this
> technical nit?

The goal isnt a technical nit, its to avoid loading 300Kbytes of crud (which 
should mostly be in user space anyway) on the 99.9% of machines where we dont
need it.

The user space thing isnt an idle comment btw, its something that I think we
should actively pursue for 2.5. By making better use of initrd and the clean
ramfsroot stuff Al wants to do we can push a lot of stuff (bootp, dhcp, 
dmi based configuration fixups, acpi) almost entirely into user space.
That makes me a lot lot happier.

The fact that it takes more code to parse and interpret ACPI than it does to
route traffic on the internet backbones should be a hint something is badly
wrong either in ACPI the spec, ACPI the implenentation or both.

Reading the code I can find some examples of pointless code bloat, but not
enough to convince me the broken part isnt the spec.

Alan

