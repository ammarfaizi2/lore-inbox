Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313013AbSC0Nrj>; Wed, 27 Mar 2002 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312483AbSC0Nr2>; Wed, 27 Mar 2002 08:47:28 -0500
Received: from [206.11.169.19] ([206.11.169.19]:64263 "EHLO wind.enjellic.com")
	by vger.kernel.org with ESMTP id <S311898AbSC0NrO>;
	Wed, 27 Mar 2002 08:47:14 -0500
Message-Id: <200203271347.g2RDlBVK015058@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Wed, 27 Mar 2002 07:47:11 -0600
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: linux-kernel@vger.kernel.org
Subject: Hamachi driver dead in 2.4.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning to everyone.

We are in the process of upgrading our computational clusters to
2.4.18 and have run into reasonably stubborn problems with the GNIC-II
driver (hamachi.c).  Transmitting *seems* to be fine but the card
refuses to receive.  We instead get receive errors flagged in the
/sbin/ifconfig list for the interface for each packet that should have
been received.

I have tried kernels with the driver statically compiled and I have
tried a modular driver with the same results.  I have turned up
debugging with the debug=n module parameter but I don't see anything
that really jumps out at me.

The target machines are dual SMP 450MHZ Pentium-II with 512 meg of
RAM.  Nothing fancy just the basic Intel grey box.  Here is the output
of lspci:

---------------------------------------------------------------------------
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:0b.0 Ethernet controller: Packet Engines Inc. PCI Ethernet Adapter (rev 01)
00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 37)
00:0d.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 37)
00:0f.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro
100] (rev 05)00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
---------------------------------------------------------------------------

The kernel was compiled with egcs-2.91.66.  The same compiler
generates a 2.2.x kernel which seems to work just fine.

I have idled out a machine for testing purposes so I can run any
diagnostics or try anything that someone can recommend.  The machines
in question are all connected to Nortel Accellar 1200 switches for as
much difference as that would make.

Thanks much for any help or suggestions that come forward.

Have a pleasant week.

Greg

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Inspite of all evidence to the contrary, the entire universe is
composed of only two basic substances: magic and bullshit."
                                -- Ian Macdonald
