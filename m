Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSIZQD0>; Thu, 26 Sep 2002 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSIZQD0>; Thu, 26 Sep 2002 12:03:26 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:12181 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261360AbSIZQDF>;
	Thu, 26 Sep 2002 12:03:05 -0400
Message-ID: <3D9330ED.4080105@colorfullife.com>
Date: Thu, 26 Sep 2002 18:08:13 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org, Jan Kasprzak <kas@informatics.muni.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The errata is not PS/2 mouse specific:
it says that the io apic doesn't implement masking interrupts correctly.

Linux uses masking aggressively - disable_irq() is implemented by 
masking the interrupt in the io apic. I'm surprised that this doesn't 
cause frequent problems. Perhaps the problem only occurs if an invalid 
cpu id is written into the target register, as done by Netware?

Is someone around with a ne2k-pci card and a AMD-760MPX based system?

Regarding Jan's problem: I'm not sure if his problems are related to 
this errata. It says that using a PS/2 mouse instead of a serial mouse 
with Novell Netward avoids the hang during shutdown, probably because 
then netware doesn't mask the irq.

--
	Manfred

