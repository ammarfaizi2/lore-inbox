Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRHKQrb>; Sat, 11 Aug 2001 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268596AbRHKQrV>; Sat, 11 Aug 2001 12:47:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41736 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268570AbRHKQrD>; Sat, 11 Aug 2001 12:47:03 -0400
Subject: Re: VIA MVP3 problem is still there...
To: jpopl@interia.pl (Jacek =?iso-8859-2?Q?Pop=B3awski?=)
Date: Sat, 11 Aug 2001 17:49:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010811163323.A555@localhost.localdomain> from "Jacek =?iso-8859-2?Q?Pop=B3awski?=" at Aug 11, 2001 04:33:23 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vbx1-0002wo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in -ac, but this broken fixup is still in 2.4.8 kernel. It affects most of
> K6-2/K6-3 users. There are stable kernels in distributions, not -ac, so IMHO it will
> be good to fix that problem at last - and it's only two lines of code:

Actually most distro kernels have the fix and are -ac based. However you
are right Linus - I'd forgotten this was still in your tree:

> --- linux-2.4.8/arch/i386/kernel/pci-pc.c       Sat Aug 11 16:19:30 2001
> +++ linux/arch/i386/kernel/pci-pc.c     Sat Aug 11 16:20:04 2001
> @@ -994,8 +994,6 @@
>         { PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     pci_fixup_ide_bases },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5597,          pci_fixup_latency },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5598,          pci_fixup_latency },
> -       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_82C691,       pci_fixup_via691 },
> -       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_82C598_1,     pci_fixup_via691_2 },
>         { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371AB_3,  pci_fixup_piix4_acpi },
>         { 0 }
>  };

