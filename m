Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRDGRtr>; Sat, 7 Apr 2001 13:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRDGRt1>; Sat, 7 Apr 2001 13:49:27 -0400
Received: from zeus.kernel.org ([209.10.41.242]:37849 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129292AbRDGRtN>;
	Sat, 7 Apr 2001 13:49:13 -0400
Message-ID: <3ACF4DBC.1CB53442@mandrakesoft.com>
Date: Sat, 07 Apr 2001 13:26:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <3ACF1525.88BCA48B@didntduck.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Gérard Roudier wrote:
> > Given your description, this board is certainly not a multi-fonction PCI
> > device. Multi-function PCI devices provide separate resources for each
> > function in a way that allows each function to be driven by separate
> > software drivers. A single function PCI device that provides several
> > functionnalities commonly handled by separate sub-systems, is nothing but
> > a bag of shit we should not want to support in any O/S in my opinion.
> > Let me claim that ingenieers that want O/Ses to support such hardware are
> > either morons or bastards.
> 
> Unfortunately, Windoze supports this configuration, and that's enough
> for most hardware designers.  This is also an issue with the joystick
> ports on many PCI sound cards.  We're not in a position to get up on the
> soap box and decree this hardware "a bag of shit" though, yet.
> 
> PS.  I have run into this issue before with joystick ports on many PCI
> sound cards.  The only one that I found that did it right (seperate PCI
> function for the game port) was the SBLive.

We -can- support multifunction cards such and these, and no we don't
need to hack the infrastructure to do it.  You might need to hack the
subsystem drivers a bit to make them more flexible, but that's it.

WRT the specific example of joystick ports, it is already possible for a
sound driver to register a joystick port.  No problem there either.

	Jeff



-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
