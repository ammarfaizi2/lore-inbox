Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbRHBR1V>; Thu, 2 Aug 2001 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbRHBR1L>; Thu, 2 Aug 2001 13:27:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26780 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267180AbRHBR1C>;
	Thu, 2 Aug 2001 13:27:02 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 17:27:07 GMT
Message-Id: <200108021727.RAA113816@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, garloff@suse.de
Subject: Re: [PATCH] make psaux reconnect adjustable
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Kurt Garloff <garloff@suse.de>

    > Not precisely - it is a boot parameter "psaux-reconnect".
    > That is better than a sysctl.

    Why should that be better than a sysctl? Boot parameters are ugly. You
    need to reboot in order to change them ...

Of course I hope that we'll handle this correctly at some point,
without any options or parameters. In my eyes a sysctl is heavier
infrastructure than a boot parameter, so I prefer the latter
when a temporary fix is needed.

    Your other mail implies that we can fix the problem without manual
    intervention by parsing AA 00 instead of just AA. If it's true, I'd=20
    consider that the best solution.=20

Maybe precisely one person reported this, and his address
now bounces. If there exist people who need this "psaux-reconnect"
they can report on the codes they see. Note that just like AA is
a perfectly normal code, also the sequence AA 00 is perfectly
normal. Testing for that only diminishes the probability of
getting it by accident.

Instead of adding boot parameters or sysctls or heuristics,
probably we should just transfer the codes seen to user space,
e.g. to gpm.  Then it is up to gpm to recognize an AA 00 sequence
and decide whether that is something special.

Andries


