Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUI1Ivi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUI1Ivi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 04:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUI1Ivi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 04:51:38 -0400
Received: from gprs214-20.eurotel.cz ([160.218.214.20]:12676 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267657AbUI1Iva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 04:51:30 -0400
Date: Tue, 28 Sep 2004 10:48:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040928084850.GA18819@elf.ucw.cz>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams> <20040925145315.GJ3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925145315.GJ3309@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There must be some way of being able to check the password is correct
> > without compromising security by encrypting static text and storing it
> > at a known location! Darned if I know what it is though.
> 
> good point! Maybe we can pick random signed chars in a 4k block and
> guarantee their sum is always -123456. Would that be secure against
> plaintext attack right? It's more like a checksum than a magic number,
> but it should be a lot more secure than the "double" typo probability
> (and this way the password will be asked only once during resume).
> Generating those random numbers will not be the easiest thing though.

Actually, better solution probably is to encrypt 32-bit zero.

Then, you have 1:2^32 probability of accepting wrong password, still
if you try to brute-force it, you'll find many possible passwords.

If you are paranoid, encrypt 16-bit zero....
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
