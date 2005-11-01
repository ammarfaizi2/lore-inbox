Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKAVAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKAVAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVKAVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:00:29 -0500
Received: from mail.linicks.net ([217.204.244.146]:55000 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751196AbVKAVA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:00:28 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Trail/trace /dev/agpgart access
Date: Tue, 1 Nov 2005 21:00:19 +0000
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511012100.19490.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the noise, but need experts :-)

This is most probably nothing to do with the kernel, but I am at a total lose 
and have exhausted all avenues after 5 days of finally getting around to 
looking into this to find out WHY I am the _only person in the world_ that 
seems to get this issue - two accesses to /dev/agpgart on startx - or X raw 
(or any other combination of X)

Please refer to this original mail:

http://lkml.org/lkml/2005/6/22/295

2.6.14 - agpgart and via-agp built in - use nVidia driver (I know, I know) on 
Geforce4 MX440 SE.

I have traced startx->xinit->startkde to no avail.

I have been on to the xorg people in irc - no-one there has ever seen similar 
(get on to nVidia)...

I coded in a pci AGP device counter in generic.c, and it does report that it 
gets accessed twice (counter resets after leaving that routine):

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode - count 1
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode - count 2
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode - count 1
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode - count 2

xorg logs here -> http://www.nick.ukfsn.org/other/Xorg.0.log

So, is there anyway I can 'watch' /dev/agpgart to see what does this?

Many thanks,

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

