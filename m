Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUIYB3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUIYB3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUIYB3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:29:48 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:36793 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269170AbUIYB3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:29:47 -0400
Date: Sat, 25 Sep 2004 03:27:05 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925012705.GC3309@dualathlon.random>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925010759.GA3309@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 03:07:59AM +0200, Andrea Arcangeli wrote:
> about it either, it'll be always different, it will be choosed randomly
> by userspace while booting the machine.
  ^^^^^^^^^^^^

while the above would work fine too, I'm starting thinking it's simpler
and cleaner to make it completely transparent to userspace, we can
choose the random key within sys_swapon, userspace will only have to
tweak if to enable the crypto-swap feature or not before calling swapon
(maybe via sysctl).
