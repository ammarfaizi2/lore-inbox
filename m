Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269422AbUI3TUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269422AbUI3TUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269420AbUI3TUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:20:10 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:38864 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269455AbUI3TRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:17:37 -0400
Date: Thu, 30 Sep 2004 21:17:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040930191720.GB32279@dualathlon.random>
References: <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams> <20040925145315.GJ3309@dualathlon.random> <20040928084850.GA18819@elf.ucw.cz> <20040930174244.GL22008@dualathlon.random> <20040930185447.GC475@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930185447.GC475@openzaurus.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 08:54:47PM +0200, Pavel Machek wrote:
> Actually if your cipher is not resistant to known plaintext attack,

AFIK the only way to make it resistent to a brute force is to make it
slow, like adding lots of bits of salt.

> you have other problems anyway. There's a lot of nearly-lnown data 
> (like name of process with pid 1) that single 32bit zero is no problem.

You could fix that later, by changing the offset randomly before writing
it to disk.

My point is very simple, that is if you leave a zero as part of the API,
then you're making things less secure.
