Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUI3Tx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUI3Tx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUI3Txz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:53:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31659 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269464AbUI3TxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:53:25 -0400
Date: Thu, 30 Sep 2004 21:52:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040930195228.GA1100@openzaurus.ucw.cz>
References: <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams> <20040925145315.GJ3309@dualathlon.random> <20040928084850.GA18819@elf.ucw.cz> <20040930174244.GL22008@dualathlon.random> <20040930185447.GC475@openzaurus.ucw.cz> <20040930191720.GB32279@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930191720.GB32279@dualathlon.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually if your cipher is not resistant to known plaintext attack,
> 
> AFIK the only way to make it resistent to a brute force is to make it
> slow, like adding lots of bits of salt.

No. If you want it resistent to brute force, use big key. Actually 128bit should be enough.

If user's password has at least 128 bits of entropy, you should be safe, too.

salt only helps with "lets create 1TB of all common encrypted passwords" attack.

> My point is very simple, that is if you leave a zero as part of the API,
> then you're making things less secure.

This is same as saying that starting encrypted email with
"Hi!" is bad idea. It is not. Don't worry about brute-force, it is not
practical. (Okay, you probably should not limit password length to 8 chars).

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

