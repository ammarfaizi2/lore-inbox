Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271871AbRH1SbH>; Tue, 28 Aug 2001 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271876AbRH1Sa5>; Tue, 28 Aug 2001 14:30:57 -0400
Received: from cs.columbia.edu ([128.59.16.20]:44206 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S271871AbRH1Saj>;
	Tue, 28 Aug 2001 14:30:39 -0400
Date: Tue, 28 Aug 2001 14:30:56 -0400
Message-Id: <200108281830.f7SIUu928840@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Multicast
In-Reply-To: <20010828111321.A8147@bougret.hpl.hp.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001 11:13:21 -0700, Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

>        And finally, I tried :
> ------------------------------------------
> bind(sock, ONE_INTERFACE, MY_PORT);
> ------------------------------------------
>        First instance : Tx ok, doesn't Rx anything at all. I can
> understand why, the Rx packet don't have a dest IP address matching
> ONE_INTERFACE.

This is the correct approach, I think. Have you tried adding the two
setsockopt() calls after the bind, or at the very least the
IP_ADD_MEMBERSHIP one, to see if you can Rx? Otherwise quite obviously
your physical interface will not have the multicast MAC address added to
its filters and no packets will reach the IP stack.

'ip maddr ls' is a useful tool for inspecting what your NIC is letting
through.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
