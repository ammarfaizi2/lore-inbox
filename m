Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbRCXGx3>; Sat, 24 Mar 2001 01:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131599AbRCXGxS>; Sat, 24 Mar 2001 01:53:18 -0500
Received: from [166.70.28.69] ([166.70.28.69]:64825 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S131595AbRCXGxE>;
	Sat, 24 Mar 2001 01:53:04 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: terje.malmedal@usit.uio.no (Terje Malmedal), linux-kernel@vger.kernel.org
Subject: Re: Alert on LAN for Linux?
In-Reply-To: <E14fm5o-0000uT-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2001 23:51:24 -0700
In-Reply-To: Alan Cox's message of "Wed, 21 Mar 2001 17:08:14 +0000 (GMT)"
Message-ID: <m1bsqr1wyb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > things correctly they have enhanced Wake-on-LAN to allow you to do
> > things like reset the machine, update the BIOS and such by sending
> > magic packets which are interpreted by the network card. Or maybe I am
> 
> Normally 'sending magic packets resets the machine' is considered a feature
> reported to bugtraq. The alert stuff I have seen is more akin to sending SNMP
> traps for things like people opening the lid, or fan failure

I haven't quite be able to track this but I don't think that is how alert on
lan works.  Rev1 has a watch dog timer that can send a packet when
booting or whatever fails.  It looks like Rev2 hooked up that watchdog
timer to the power or the reset switch.  So it doesn't reboot for
everything but it does look like it can reboot for some specific
special cases.

And if it is of the watchdog timer approach it looks like it could
actually be useful.  Of course someone needs to track down the docs so
we can actually use it.

Eric

