Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUBHV3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUBHV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:29:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43983 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264113AbUBHV3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:29:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Linux 2.6.3-rc1
Date: Sun, 8 Feb 2004 22:34:22 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402071722.10242.bzolnier@elka.pw.edu.pl> <4025D0F2.1020400@tomt.net>
In-Reply-To: <4025D0F2.1020400@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402082234.22043.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 of February 2004 07:02, Andre Tomt wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 07 of February 2004 11:24, Andre Tomt wrote:
> >>pdc202xx_old OOPS's on load in case of completely modular IDE (core and
> >>pci ide drivers). I have yet to capture the OOPS, as someone has just
> >>ran away with the one serial cable over here.
> >>
> >>If we're lucky Bart knows what's missing without the trace ( :-) ! ). If
> >>not, I'll see if I can get netconsole up and running.
> >>
> > :-(
> >
> > Please try to capture this OOPS.
>
> Hmm. Netconsole just hangs my kernel, probably due to me mis-merging it
> into  2.6.3-rc1. So here it is, the pen and paper version :-)

Thanks :-).

> It is somewhat shortened, if you need more information from the oops,
> ask and I'll see what I can do.

Do you load any other IDE host modules before pdc202xx_old?

> Unable to handle kernel virtual paging request at virtual address 24748b24
>
> EIP is at ide_pci_register_host_proc+0x27/0x40 [ide_core]

Can you disassemble ide_pci_register_host_proc using gdb?

> init_chipset_pdc202xx	[pdc202xx_old]
> do_ide_setup_pci_device	[ide_core]
> ide_setup_pci_device	[ide_core]
> pdc202xx_init_one	[pdc202xx_old]
> create_dir
> pci_device_probe_static
> __pci_device_probe
> pci_device_probe
> bus_match
> driver_attach
> bus_add_driver
> driver_register
> pci_register_driver
> ide_pci_register_driver	[ide_core]
> pdc202xx_ide_init	[pdc202xx_old]
> sys_init_module
> syscall_call

