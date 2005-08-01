Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVHAAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVHAAfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHAAfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:35:45 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64749 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262204AbVHAAfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:35:42 -0400
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re:
	-rc4: arm broken?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050730223628.M26592@flint.arm.linux.org.uk>
References: <20050730130406.GA4285@elf.ucw.cz>
	 <1122741937.7650.27.camel@localhost.localdomain>
	 <20050730201508.B26592@flint.arm.linux.org.uk>
	 <20050730223628.M26592@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Aug 2005 02:01:07 +0100
Message-Id: <1122858068.15622.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-30 at 22:36 +0100, Russell King wrote:
> Since PCMCIA cards are detected and drivers bound at boot time, we no
> longer get hotplug events to setup networking for PCMCIA network cards
> already inserted.  Consequently, if you are relying on /sbin/hotplug to
> setup your PCMCIA network card at boot time, triggered by the cardmgr
> startup binding the driver, it won't happen.

So eth0 now randomly changes between on board and PCMCIA depending upon
whether the PCMCIA card was inserted or not, and your disks re-order
themselves in the same situation. That'll be funny if anyone does a
mkswap to share their swap between Linux and Windows. Gosh look there
goes the root partition.

I'm hoping thats not what you are implying. Especially for disks,
network is much much less of an issue.

