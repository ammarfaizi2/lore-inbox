Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbUCMPnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 10:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbUCMPnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 10:43:47 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:38557 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263115AbUCMPnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 10:43:46 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 13 Mar 2004 15:43:43 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout RESOLVED
Message-ID: <40532C2F.25618.23B1E406@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Firstly, I am starting a fresh thread here, as I have subscribed to 
> the lkml now so I can reply in a timely manner, and also the other 
> thread was broke as I was replying 'off-list' - sorry about that.
> 
> OK, to recap.  With 2.6.3 I get timeouts with 8139too under network 
> load (any load).  I have never had any problems with these _same_ two 
> cards under any other kernel version over the last 3 years.
> 
> If I use the 8139too.c from 2.6.2, and build 2.6.3 with it, all works 
> fine (I am running this version right now).
~snip~

OK, just for completeness, this issue has been resolved.

In my BIOS, there was an option:

PCI IRQ  (edge/level)

It was set to 'edge'.  Setting to 'level' fixed the problem - the 
8139too.c driver is perfectly OK (I am now on 2.6.4 with no 
problems).

I would like to thank OGAWA Hirofumi for the time and debugging code 
he done for me, and also successfully pinpointing the problem and 
giving me an idea of what was going on and what to look for to fix 
it.

Thank you!

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

