Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292890AbSCERJV>; Tue, 5 Mar 2002 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292898AbSCERJG>; Tue, 5 Mar 2002 12:09:06 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:64981 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S292890AbSCERIt>; Tue, 5 Mar 2002 12:08:49 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 09:08:20 -0800
Message-Id: <200203051708.JAA05742@adam.yggdrasil.com>
To: sp@scali.com
Subject: Re: Does kmalloc always return address below 4GB?
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold writes:
>I know pci_map_single (and _sg) will
>use bounce buffers on platforms without an IOMMU [...]

	For a moment I thought that must be the point that I
was missing, but I don't see any such bounce buffer support
in linux-2.5.6-pre2/include/asm-i386/pci.h or arch/i386/kernel/pci-dma.c.
I do not see how this is currently implemented on x86 systems with >4GB
of RAM.

	Or, by "will use" did you mean "will implement in the future?"

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
