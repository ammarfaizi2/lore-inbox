Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267823AbTBROVM>; Tue, 18 Feb 2003 09:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTBROVL>; Tue, 18 Feb 2003 09:21:11 -0500
Received: from [207.61.129.108] ([207.61.129.108]:19097 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S267823AbTBROVK>; Tue, 18 Feb 2003 09:21:10 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: "Russell King" <rmk@www.linux.org.uk>
Subject: [BUG][2.5.xx][SERIAL] Bogus output from serial driver detection
Date: Tue, 18 Feb 2003 09:32:49 -0500
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302180932.49685.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From dmesg:

serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:12' and the driver 'serial'
pnp: res: the device '00:12' has been activated.
ttyS0 at I/O 0x3f8 (irq = 3) is a 16550A
pnp: match found with the PnP device '00:13' and the driver 'serial'
pnp: match found with the PnP device '01:02.00' and the driver 'serial'
pnp: res: the device '01:02.00' has been activated.
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A

Notice ttyS1 and ttyS0 are both reporting irq 3. This is impossible because 
IBM's BIOS refuses to let me share IRQ's with serial ports. This is also 
causing a problem with the ISA PnP modem which apparently doesn't have an IRQ 
that it can use because of this.

Shawn.

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

