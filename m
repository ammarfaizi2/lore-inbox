Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTBJF1U>; Mon, 10 Feb 2003 00:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTBJF1T>; Mon, 10 Feb 2003 00:27:19 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:2007
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S261302AbTBJF1S>; Mon, 10 Feb 2003 00:27:18 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Paul Laufer <paul@laufernet.com>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc) - Failed
Date: Mon, 10 Feb 2003 00:36:56 -0500
User-Agent: KMail/1.6
References: <200302072217.24380.spstarr@sh0n.net> <20030208075339.GA13115@hal9000.laufernet.com>
In-Reply-To: <20030208075339.GA13115@hal9000.laufernet.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302100036.56796.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.114.185.204] using ID <shawn.starr@rogers.com> at Mon, 10 Feb 2003 00:36:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 01:01.02
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
isapnp: 2 Plug & Play cards detected total

sb: Init: Starting Probe...
pnp: the card driver 'OSS SndBlstr' has been registered
pnp: pnp: match found with the PnP card '01:01' and the driver 'OSS SndBlstr'
pnp: Automatic configuration failed for device '01:01.00' due to resource 
conflicts
sb: Init: Done

01:01.00 = Creative SB32 PnP
id = CTL0031

Conflicted by: 03f8-03ff : serial 
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

from 01:01.00/possible:

Dependent: 01 - Priority preferred
   port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
   port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
   port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding <----------
   irq 5 High-Edge
   dma 1 8-bit byte-count compatible
   dma 5 16-bit word-count compatible

Adam is working on resource conflict fixes to PnP to let us see and possibly 
fix conflicts like this.

Shawn.

On Saturday 08 February 2003 2:53 am, Paul Laufer wrote:
> Sorry, I sent a version of sb_card.c that was what I last minute
> tested minus one change. The #include for sb_card.h should be under
> the #include of pnp.h. Here is the patch. It should work after you
> apply this.
>
> Thanks for testing.
>
> Paul
>

