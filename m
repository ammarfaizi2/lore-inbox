Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTAJUHU>; Fri, 10 Jan 2003 15:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbTAJUHU>; Fri, 10 Jan 2003 15:07:20 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:47552 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S266069AbTAJUHS>; Fri, 10 Jan 2003 15:07:18 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.55][PATCH] SB16 convertation to new PnP layer - Didn't work :(
Date: Fri, 10 Jan 2003 15:16:03 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301101516.03419.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From dmesg:

pnp: Calling quirk for 02:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 02:01.02
pnp: AWE32 quirk - adding two ports
isapnp: No Plug & Play card found   <-- this is WRONG

Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Dec 17 19:01:13 
2002 UTC).
pnp: the card driver 'opl3sa2' has been registered
pnp: the card driver 'sbawe' has been registered
pnp: pnp: match found with the PnP card '01:01' and the driver 'sbawe'
sbawe: isapnp configure failure (no device or busy)
ALSA device list:
  No soundcards found.

ALSA cannot find this model of the SBAWE32

Information from /sys:

/sys/bus/pnp_card/devices/01:01:

Name: Creative SB32 PnP
 
02:01.00/:

Name: Audio

Possible: (Priority preferred)

Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible

id: CTL0031

Resources: DISABLED

* NOTE: On this motherboard there is also a PnP ISA USRobotics modem which has 
a com port. When COM2 is enabled, this conflicts with the SBAWE32 IDE (which 
is known).

02:01.02/:

Name: WaveTable

Possible: (Priority preferred)

Dependent: 01 - Priority preferred
   port 0x620-0x620, align 0x0, size 0x4, 16-bit address decoding
   port 0xa20-0xa20, align 0x0, size 0x4, 16-bit address decoding
   port 0xe20-0xe20, align 0x0, size 0x4, 16-bit address decoding

id: CTL0021

Resources: DISABLED

There are other components on this card such as the EIDE control but this 
broken right now ;-) they have been omitted from this email


-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

