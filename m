Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTJOSfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTJOSeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:34:06 -0400
Received: from hugin.maersk-moller.net ([193.88.237.237]:43141 "EHLO
	hugin.maersk-moller.net") by vger.kernel.org with ESMTP
	id S263963AbTJOScr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:32:47 -0400
Message-ID: <3F8D929F.1000506@maersk-moller.net>
Date: Wed, 15 Oct 2003 20:31:59 +0200
From: Peter Maersk-Moller <peter@maersk-moller.net>
Organization: Visit <http://www.maersk-moller.net/>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Stoffel <stoffel@lucent.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
References: <3F8D1377.3060509@maersk-moller.net>	<3F8D3A47.1000804@maersk-moller.net> <16269.34470.987994.870487@gargle.gargle.HOWL>
In-Reply-To: <16269.34470.987994.870487@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

John Stoffel wrote:
> My system has the Intel GX chipset, what does yours have? 

BX440

> I've also
> turned off ACPI in the bios, but I do have:

Not sure i can do that - must check.

To be a little bit more detailed, in the PC are installed the following

   a) AGP Matrox 400 or 450
   b) PCI 3c95x
   c) PCI Adaptec 29160
   c) PCI bttv WinTV
   e) Free
   f) ISA pnp Winmodem
   g) ISA pnp SB16

Yes, it's an old machine ;-)

Anyway, removing all but the AGP card and moving the controller to slot b)
and then installing the cards as

   a) AGP Matrox 400 or 450
   b) PCI Adaptec 29160
   c) PCI 3c95x
   d) PCI bttv WinTV
   e) Free
   f) ISA pnp SB16
   g) ISA pnp Winmodem

cures the problem both with and without SMP and IO-APIC enabled.
So far so good for me. I suspect some how there was an undetected
IRQ/ISA/PCI problem, but that still mean that the driver can work
well with the IO-APIC disabled while hanging when IO-APIC enabled.

If anybody want's to persue this, I'd be happy to reproduce
the error.

Kind regards

----------------------------------------------------------------
Peter Maersk-Moller
----------------------------------------------------------------
Ogg/Vorbis support for MPEG4IP. YUV12, XviD, AVI and MP4 support
for libmpeg2. See http://www.maersk-moller.net/projects/
----------------------------------------------------------------

