Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUI0PrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUI0PrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUI0PrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:47:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:23999 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266491AbUI0PrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:47:17 -0400
Date: Mon, 27 Sep 2004 17:38:57 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stefan Seyfried <seife@suse.de>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
Message-ID: <20040927153857.GJ28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <4158250E.9020005@suse.de> <20040927150702.GI28865@dualathlon.random> <415830D2.6030203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415830D2.6030203@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 05:25:06PM +0200, Stefan Seyfried wrote:
> Andrea Arcangeli wrote:
> >On Mon, Sep 27, 2004 at 04:34:54PM +0200, Stefan Seyfried wrote:
> 
> >Your "close-lid with suspend-to-disk" without ever asking password in
> >suspend is fundamentally unfixable, unless you use public key
> 
> or unless i enter it on every boot.

yes.

> >Probably the next best thing you can do is to ask a preventive suspend
> >password during boot, for the suspend-capable-machines. That would be
> >more reasonable since I'd leave it disabled on my desktop.
> 
> or just enter the cryptoswap password on every boot / resume :-)

but I don't need to, so I'd leave it disabled instead.

I'd also really leave the two things separated. There's no reason the
user should ever know the cryptoswap password. it only needs to know the
suspend/resume password. This way the cryptoswap password can be
choosen very big randomly and in turn with a lot more random bits than
what an user could remember by memory.

So you should only consider asking a "preventive" suspend password,
never the cryptoswap password, the latter will be transparent to the
user. suspend will automatically store safely the cryptoswap password on
disk, so you shouldn't even notice the swap methods are encrypting data.
