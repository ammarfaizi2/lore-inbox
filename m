Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSKLUml>; Tue, 12 Nov 2002 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266942AbSKLUml>; Tue, 12 Nov 2002 15:42:41 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:36824 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S266939AbSKLUmk>; Tue, 12 Nov 2002 15:42:40 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: ACPI patches updated (20021111)
Date: Tue, 12 Nov 2002 12:48:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New patches are up on sf.net/projects/acpi. Non-Linux-specific releases will
be available by tomorrow evening at
http://developer.intel.com/technology/iapc/acpi/downloads.htm .

If you've been having problems with reading battery or other information
being very slow, please try this release and report if problems persist.

Regards -- Andy

----------------------------------------
11 November 2002.  Summary of changes for version 20021111.


0) ACPI Specification 2.0B is released and is now available
at:  http://www.acpi.info/index.html

1) Linux

Module loading/unloading fixes (John Cagle)

Other minor fixes

2) ACPI CA Core Subsystem:

Implemented support for the ACPI 2.0 SMBus Operation Regions.
This includes the early detection and handoff of the request
to the SMBus region handler (avoiding all of the complex field
support code), and support for the bidirectional return packet
from an SMBus write operation.  This paves the way for the
development of SMBus drivers in each host operating system.

Fixed a problem where the semaphore WAIT_FOREVER constant was
defined as 32 bits, but must be 16 bits according to the ACPI
specification.  This had the side effect of causing ASL
Mutex/Event timeouts even though the ASL code requested a wait
forever.  Changed all internal references to the ACPI timeout
parameter to 16 bits to prevent future problems.  Changed the
name of WAIT_FOREVER to ACPI_WAIT_FOREVER.



-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

