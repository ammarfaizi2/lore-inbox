Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTI0KXS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 06:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTI0KXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 06:23:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:41344 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262422AbTI0KXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 06:23:16 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 27 Sep 2003 12:23:26 +0200
MIME-Version: 1.0
Subject: Re: How to understand an oops?
Message-ID: <3F75813E.16883.2840FDB0@localhost>
In-reply-to: <20030923111621.5b583d62.rddunlap@osdl.org>
References: <3F709F7E.28657.152F28ED@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>... 
> | > | How likely is it that a bug in net/core/skbuff.c is causing the 
> | > | kernel panic?
> | > 
> | > Dunno.  It's trying to access memory at (%ebx) == 00200000.
> | > That could be a single-bit error in memory which was supposed to be
> | > 0, which would have terminated the while loop in skb_drop_fraglist().
> | > 
> | > The common suggestion based on this would be to run memtest86
> | > (or memtst86 ?) overnight to check for memory errors.
> | > 
> | 
> | I already run memtest for about 25 hours without any error.
> | If it's not a memory error how can I find out what caused the error? 
> | Debugger?
> | 
> | > | How can I find other code/modules from which skb_drop_fraglist is 
> | > | called and used?
> | > 
> | > Use grep (or cscope, but that would be overkill in this case).
> | > I found it only in net/core/skbuff.c.
> | > 
> 

sk_buff is used by network drivers. How can I narrow down the error 
in skb_drop_fraglist? Maybe it's a network driver problem and not 
Promise-IDE related.

> In the meantime, you haven't tried the other mailing lists that
> I suggested....
> 

I did but didn't get any reaction.

I don't know how to go on. I can't verify my configuration under 
kernel 2.6.x or 2.4.22-ac4 as 2.6.x doesn't boot (blank screen and 
yes, I tried different CONFIG_CONSOLE settings). 2.4.22-ac4 hangs 
with an oops when booting. Under 2.4.23pre1 I'm getting the same 
errors.

Can I do some debugging to narrow down the problem? I still don't 
know if the error is network or Promise driver related.

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

