Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKIUXn>; Thu, 9 Nov 2000 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129566AbQKIUXd>; Thu, 9 Nov 2000 15:23:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:28691 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129045AbQKIUXX>;
	Thu, 9 Nov 2000 15:23:23 -0500
Date: Thu, 9 Nov 2000 21:22:28 +0100
Message-Id: <200011092022.VAA03494@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: root@chaos.analogic.com ("Richard B. Johnson")
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
        Brian Gerst <bgerst@didntduck.org>
Subject: Re: Module open() problems, Linux 2.4.0
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.3.95.1001109150621.15404A-100000@chaos.analogic.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1001109150621.15404A-100000@chaos.analogic.com> you wrote:
> This may be, as you say, "harmless". It is, however, a bug. The
> reporting must be correct or large complex systems can't be
> developed or maintained.

No.  It is not.  The module usage count doesn't have a direct relation
to the number of open devices.  The module count just makes the modules
un-removable if it is non-zero.  It doesn't matter at all, when and where
you in- and decrease it, as long as the module is always protected against
unload when in use (e.g. opened).

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
