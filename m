Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319538AbSH3KaL>; Fri, 30 Aug 2002 06:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319539AbSH3KaL>; Fri, 30 Aug 2002 06:30:11 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:55787 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S319538AbSH3KaK>;
	Fri, 30 Aug 2002 06:30:10 -0400
Message-ID: <3D6F4A3A.50806@beam.ltd.uk>
Date: Fri, 30 Aug 2002 11:34:34 +0100
From: Terry Barnaby <terry@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux kernel lockup with BVM SCSI controller on MCPN765 PPC board
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a major problem with using a BVM SCSI controller on a Motorola
MCPN765 PowerPC Compact PCI Motherboard. When the SCSI driver module is
loaded and starts to perform SCSI device interrogation the system will
completely lock up.
It appears that the hardware is locked up, the kernel locks up during
a low level serial console print routine (serial_console_write). No interrupts
occur (we have even disabled interrupts in the serial_console_write routine
to make sure).
The BVM SCSI controller is based on the LSI53C1010-66 chip and we are using the
sym53c8xx_2 SCSI driver (although the same problem occurs with the
sym53c8xx SCSI driver.
We are using MontaVista Linux 2.1 with the 2.4.17 kernel.

Using this SCSI controller board with a Motorola MCP750 PowerPC motherboard
works fine. One of the differences between the Motherboards is that the
MCPN765 has a 66MHz/64bit PCI bus while the MCP750 has a 33MHz/32bit PCI bus.
The MCPN765 uses a Hawk ASIC for Memory/PCI bus control.

We have been attempting to debug the driver to find the cause but have been
hitting brick walls. The system appears to lock up when the SCSI board
is performing a DataIn phase under the control of its on-board SCRIPTS processor.

As the system has completely locked up we have not been able to find the cause.
Any information on possible causes or ideas on how to proceed would be most
appreciated.

Terry
-- 
   Dr Terry Barnaby                     BEAM Ltd
   Phone: +44 1454 324512               Northavon Business Center, Dean Rd
   Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
   Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
   BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                          "Tandems are twice the fun !"

