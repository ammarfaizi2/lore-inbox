Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLMSSc>; Wed, 13 Dec 2000 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbQLMSSW>; Wed, 13 Dec 2000 13:18:22 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:1551 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129784AbQLMSSQ>; Wed, 13 Dec 2000 13:18:16 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200012131747.eBDHlmx18061@devserv.devel.redhat.com>
Subject: Re: linux 2.2.18  inconsistencies/problems (minor)
To: mikesw@whiterose.net (M Sweger)
Date: Wed, 13 Dec 2000 12:47:48 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012131159540.23922-100000@whiterose.net> from "M Sweger" at Dec 13, 2000 12:08:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A). Problem with the "%d" in usb-serial. Note: I don't have
>     any devices connected to any USB port, but the controllers

Real bug - thanks. I'll squash that in 19pre1

> B). Need to update the devices.txt document in the Documentation
>     sub-directory. I checked the maintainers site and it is the same
>     one as delivered with this kernel version. However, it is out-of-date
>     since there are quite a few devices missing, i.e. cpuid  major #
>     203  and others.  I've emailed the author of the document around 
>     October 2000, but haven't seen this document updated for the
>     linux v2.2.x kernels. I assume the v2.4 devices.txt document is
>     the same. If so, then the document would need to clarify what
>     what devices are valid for each kernel (2.0, 2.2, 2.4)
>     so that devices that don't exist in these older kernel versions
>     aren't created. 

I've been talking to HPA already about that

>  C).  Problem cat'g the proc pci bus files.
> 
> cat /proc/bus/pci/00/00.0
> 
> Get non-printable characters

Not a bug. That is the raw pci configuration data

> 	   When the ACPI option is disabled, then hitting the 
>            power switch will turn the PC off without going into 
>            standby.

We dont support ACPI in 2.2 just 2.4test

> 	b). The BIOS option to power-on the PC via the LAN is disabled
>             in the PC setup screens.

Probably your ethernet card doesnt support it.

Can you report the APM problem to the APM maintainer ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
