Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTHWMjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTHWMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:35:37 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:17329 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263685AbTHWMdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:33:40 -0400
Message-ID: <003701c36972$a980e1d0$78ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Input issues - key down with no key up
Date: Sat, 23 Aug 2003 21:30:21 +0900
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

Although I cannot keep up with the list, I saw this.
"Jamie Lokier" <jamie@shareable.org> asked John Bradford:

> So do the Japanese keys fail to work in Windows, too, without a
> special driver?

I cannot answer for John Bradford's particularly odd keyboard, but can
answer for ordinary Japanese PS/2 and Japanese USB keyboards.

If a Monopolysoft Windows system is running with a US-101 keyboard driver,
then in principle the Japanese keys produce no input, they are ignored, they
are no-ops.  The US-101 driver can be combined with the US layout driver to
match an actual US keyboard, or combined with a German layout driver to
match an actual German keyboard, etc.  If the US layout driver is used but
the keyboard is actually Japanese then the hankaku/zenkaku key produces
input of ` and ~ or something like that, because the US keyboard has that
key in that place.  If the German layout driver is used but the keyboard is
actually Japanese then I don't know if something similar might happen.

For non-Japanese versions of Windows 95 or 98 or NT4, there are hacks, not
supported by Microsoft, to combine the US-101 driver with the Japanese
layout driver copied from the corresponding Japanese version of Windows 95
or 98 or NT4.  In these cases the Japanese keys might or might not produce
input, depending on other random software and settings.

For Japanese versions of Windows 95 or 98 or NT4, of course the Japanese
keys do produce input.  Of course the Japanese layout driver is involved.  I
don't recall if the lower-level keyboard driver has a name that
distinguishes it from the US-101 driver, but the binaries are almost
certainly different.

For Windows 2000 and XP, essentially the same drivers are available in both
Japanese and non-Japanese versions of the OS, though Japanese Windows 2000
includes some extra compounding of hacks to work around one particular
installation-time bug instead of fixing the installation-time bug.  Anyway,
the Japanese-106 keyboard driver is a competitor of the US-101 keyboard
driver.  If the US-101 keyboard driver is installed then the Japanese layout
driver doesn't work even if it's selected, except in the case of the
compounded hack just mentioned.  If the Japanese-106 keyboard driver is
installed then I think it's possible to install either the US-101 layout
driver or Japanese-106 layout driver.  When the Japanese-106 layout driver
is running, of course the Japanese keys produce input.  When the US-101
layout driver is running, the Japanese keys are no-ops, except that the
hankaku/zenkaku key produces ` and ~ for same reason as earlier.

If a USB keyboard is used with an OS that has USB drivers (i.e. not NT4 or
early 95) then I think the OS is smart enough to figure out the actual
layout of the keyboard, at least sometimes.  Then the Japanese keys might
produce input even when the user expected them to be no-ops.  But if the
Japanese IME isn't running then I think the input will still turn into
no-ops, just a bit later in the chain of events than they would otherwise.

If you consider the Japanese-106 driver to be more special than the US-101
driver, then the answer to your question is usually yes, but you need an
attitude adjustment  :-)  If the US-101 driver can be hacked to work with a
larger number of national or linguistic layouts than the Japanese-106 driver
can, then the US-101 driver is the one that's special  :-)

