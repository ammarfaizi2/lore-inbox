Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbQLUTKO>; Thu, 21 Dec 2000 14:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbQLUTKE>; Thu, 21 Dec 2000 14:10:04 -0500
Received: from sco.sco.COM ([132.147.128.9]:33540 "HELO sco.sco.COM")
	by vger.kernel.org with SMTP id <S130612AbQLUTJw>;
	Thu, 21 Dec 2000 14:09:52 -0500
Message-ID: <3A424CAE.E9147E13@cruzio.com>
Date: Thu, 21 Dec 2000 10:32:14 -0800
From: Bruce Korb <bkorb@cruzio.com>
Reply-To: bkorb@cruzio.com
Organization: Home
X-Mailer: Mozilla 4.7 [en] (X11; U; SCO_SV 3.2 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: Thierry Vignaud <tvignaud@mandrakesoft.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown PCI device?
In-Reply-To: <Pine.LNX.4.31.0012210412560.748-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike A. Harris" wrote:
> >> Anyone know what this is?
> >>
> >> 00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
> >>         Flags: medium devsel
> >
> >if its pci id is 0x11063050, then it's a VIA Power Management Controller.
> 
> 00:07.3 Class 0600: 1106:3050 (rev 30)
>         Flags: medium devsel
> 
> Yip.  Someone might want to update the PCI ID db, or whatever
> with that..

If this were to be adopted:

  ftp://autogen.linuxave.net/pub/PCIDEV.tgz

I would finish it so that there would be one and only one place to
update for any and all PCI devices for 2.2, 2.4 and any other
kernel.  However, it would take several days and I won't do it
unless there were some reasonable chance for adoption.  The
referenced implementation only covers the 2.4 kernel:

1.  the list of PCI manufacturers and devices
2.  the IDE controllers

still to do would be the dispatch tables for other kinds of
devices, the tables for the 2.2 kernel and the device information
for the non-IDE dispatch tables.  (The latter being the hard
[time consuming] part.  Creating the tables from the data is
easy.)

Once this is all done, both the 2.2 and 2.4 (and future) kernels
would be kept up to date by updating a single database and regenerating
the tables.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
