Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbVGNXAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbVGNXAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVGNW7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:59:53 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:25259 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S263170AbVGNWwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:52:54 -0400
Message-Id: <42D6ECED.7070504@khandalf.com>
Date: Fri, 15 Jul 2005 00:53:33 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rvk@prodmail.net, linux-kernel@vger.kernel.org
Subject: Re: Buffer Over-runs, was Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
    <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>
    <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>
In-Reply-To: <42D658A9.7050706@prodmail.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Md5-Body: 737aa6586687fdbcd4ee6b3d773d1505
X-Transmit-Date: Friday, 15 Jul 2005 0:53:46 +0200
X-Message-Uid: 0000b49cec9dcff7000000020000000042d6ecfa000206dd00000001000bc861
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@84-73-132-32.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32700; Body=1
	Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First there are endless ways of stopping DAMAGE from buffer
over-runs, from code that accepts user data, eg extend buffer, dont
use dangerous strxxx functions .... so while you can move
stuff to proxies, and that has been done extensively e.g.
for sendmail it is a cop-out, far better fix the application;

Next, while all buffer over runs are very bad it is only those
that stamp on the stack, overwriting the return address stored
there and implanting viral code to be executed, that are truely
__EVIL__.

To do that you need to know a lot of things, the architecture
ie executing x86 code on a ppc will get you no-where, you must
know, and be able to debug your mal-ware against a stable
target, and this is why the _VERY_ slowly patched Windoze is
so vulnerable, and finally you really need to know the stack
base, top of stack, normally growing downward, and ... be able
to actually run code out of the stack space;

and if any one of these conditions are not true, eg I compiled
sendmail with a newer GCC, stack is not executable, ...

the exploit just fails or crashes an app and then you go after
why?

but your system is not compromised.

One final point, in practice, you get lots of unwanted packets
off the internet, and in general you do not want them on your
internal net, both for performance and security reasons, if you
drop them on your router or firewall then you dont need to
worry if the remote app is mal-ware.

-- 
mit freundlichen Grüßen, Brian.

