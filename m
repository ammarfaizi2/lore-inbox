Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266913AbRGMB0g>; Thu, 12 Jul 2001 21:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRGMB0Q>; Thu, 12 Jul 2001 21:26:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:25101 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266913AbRGMB0J>;
	Thu, 12 Jul 2001 21:26:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15182.19958.799226.696782@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jul 2001 11:25:10 +1000 (EST)
To: Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Cannot access PCI device
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188E07@tcint1ntsrv>
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188E07@tcint1ntsrv>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zehetbauer Thomas writes:

> Hi! I am trying to access a custom PCI device on a Walnut Rev. D system
> running Hard Hat Linux Rev. 1.2 with Montavista kernel snapshot
> 01.04.12. The following code is beeing executed in the probe function of
> a kernel module and works well on Linux 2.4.2/Intel but returns useless
> values on PowerPC.

What kernel version is this?  We have fixed a few bugs in the PCI code
on PPC lately.

> ### begin ppc result ###
> Found PCI device 10ee:4030 (Xilinx, Inc.)
> pci_resource_start=10000000
> pci_resource_end=0
> PCI_BASE_ADDRESS_0=ffff0000

This looks bogus, it looks like the firmware hasn't assigned an
address to this device.  Current PPC kernels should assign a
reasonable address in this case - this is something that has been
fixed since 2.4.2 came out.

Paul.
