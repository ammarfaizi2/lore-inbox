Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUIYOyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUIYOyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUIYOyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 10:54:06 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22736 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269351AbUIYOyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 10:54:01 -0400
Date: Sat, 25 Sep 2004 16:53:15 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925145315.GJ3309@dualathlon.random>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096114881.5937.18.camel@desktop.cunninghams>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 10:21:21PM +1000, Nigel Cunningham wrote:
> There must be some way of being able to check the password is correct
> without compromising security by encrypting static text and storing it
> at a known location! Darned if I know what it is though.

good point! Maybe we can pick random signed chars in a 4k block and
guarantee their sum is always -123456. Would that be secure against
plaintext attack right? It's more like a checksum than a magic number,
but it should be a lot more secure than the "double" typo probability
(and this way the password will be asked only once during resume).
Generating those random numbers will not be the easiest thing though.
