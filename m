Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTEMOLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTEMOLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:11:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261309AbTEMOLr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:11:47 -0400
Date: Tue, 13 May 2003 10:24:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: What exactly does "supports Linux" mean?
In-Reply-To: <1052830415.432.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0305131016180.238@chaos>
References: <20030513151630.75ad4028.skraw@ithnet.com>
 <1052830415.432.2.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Alan Cox wrote:

> On Maw, 2003-05-13 at 14:16, Stephan von Krawczynski wrote:
> > I bought a card from some vendor, claiming "support for Linux". I tried
> to make
> > it work in a configuration with a standard 2.4.20 kernel from kernel.org.
> The
> > drivers (kernel modules) are binary-only. They did not load because of a
> > version mismatch. Asking for versions loadable with standard kernels,
> I got the
> > response that they only support kernels from Red Hat and SuSE, but
> no standard
> > kernels.
>

If you really want it to work, try `insmod -f modulename.o`. See of it
works. RedHat supplies kernels with "intermediate" version numbers
like linux-2.4.18-24. A perfectly-good module from linux-2.4.18
may fail to load without the '-f' option, even though it is probably
compatible. Try it, it may work fine. You can modify /etc/rc.d/rc.local
to insert the module during startup so you don't have to muck with
/etc/modules.conf (and having other startup-code change it when it
"finds" new hardware.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

