Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275945AbTHOMmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275946AbTHOMmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:42:24 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:29063 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S275945AbTHOMmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:42:15 -0400
Message-ID: <0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <20030815111442.A12422@flint.arm.linux.org.uk>
Subject: Re: Trying to run 2.6.0-test3
Date: Fri, 15 Aug 2003 21:39:07 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" <rmk@arm.linux.org.uk> replied to me:

> > 1.  Although both yenta and i82365 are compiled in, my 16-bit NE2000 clone
> > isn't recognized.  If I boot kernel 2.4.19 I can use the network, if I
> > boot kernel 2.6.0 I can't find any way to use the network.  Partial output
> > of various commands and files are shown below.
>
> As a general rule, you should be using yenta not i82365.  There have
> been some historical problems when you build both into the kernel,
> so you might like to try disabling i82365.

I will do that in my next build.  For some reason I wasn't sure if yenta
would handle 16-bit cards.  But this turns out not to be necessary.  Also
the PCMCIA suggestions which Felipe Alfaro Solana suggested (the suggestions
which I intended to try) turned out not to be necessary.  The winner is the
next one:

> I don't see any sign of cardmgr starting up in your message logs,

You're right.  I started it from the command line.  It didn't recognize the
existing card, but "cardctl eject 0" followed by "cardctl insert 0" taught it.

Now the question is why cardmgr doesn't start automatically in 2.6.0-test3.
In 2.4.19, PCMCIA support was a module, for which I guess I never bothered
to change SuSE's default.  In 2.6.0-test1 since had to set all options
myself, I compiled in PCMCIA support, and it's still that way in test3.
I'll try to see if I can find the reason, though of course you might be able
to guess it instantaneously.

Thank you.
