Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311363AbSCMUxd>; Wed, 13 Mar 2002 15:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311368AbSCMUxY>; Wed, 13 Mar 2002 15:53:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:56744 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311363AbSCMUxP>;
	Wed, 13 Mar 2002 15:53:15 -0500
Date: Wed, 13 Mar 2002 21:53:12 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203132053.VAA08613@harpo.it.uu.se>
To: jc254@newton.cam.ac.uk
Subject: Re: IO-APIC -- lockup on machine if enabled
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002 15:58:29 GMT, Jonathan H N Chin wrote:
>> > i have a new laptop (Dell Latitude C610) running 2.4.18-rc4.  when i built the
>> > new kernel, i thought i would amuse myself by turning on IO-APIC.
>
>> "Don't do that"  8-)
>
>
>Unfortunately, at least on my C800 here, not using it breaks IEEE1394:
>
>    kernel: ohci1394_0: Waking dma ctx=2 ... processing is probably too slow
>
>and communication breaks down shortly after (have to unload/reload the
>modules to make it work again). On the other hand, with IO-APIC + Local
>APIC enabled (APM and ACPI disabled) firewire works fine.

Your C800 works with local APIC enabled if APM is disabled? Cool.
This indicates that the DMI blacklisting rules in my dmi-apic-fixups
patch should be relaxed to permit local APIC use on Dell laptops,
IF APM is disabled in the BIOS. There's already a rule for that
(used for the MSI-6163 mb) so it's a trivial change.

/Mikael
