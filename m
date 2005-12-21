Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVLUJiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVLUJiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVLUJiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:38:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:56211 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932337AbVLUJiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:38:13 -0500
In-Reply-To: <20051221091114.GA8495@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: ak@suse.de, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, mpm@selenic.com, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       sri@us.ibm.com
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF64F635C2.05062E9D-ON882570DE.0034368A-882570DE.0034EEAA@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 21 Dec 2005 01:39:14 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 12/21/2005 02:39:16,
	Serialize complete at 12/21/2005 02:39:16
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not do it the other way? "If you don't hear from me for 2 minutes,
> do a switchover". Then all you have to do is _not_ to send a packet --
> easier to do.
> 
> Anything else seems overkill.
>                         Pavel

        Because in some of the scenarios, including ours, it isn't a
simple failover to a known alternate device or configuration --
it is reconfiguring dynamically with information received on a
socket from a remote machine (while the swap device is unavailable).
        Limited socket communication without allocating new memory
that may not be available is the problem definition. Avoiding the
problem in the first place (your solution) is effective if you
can do it, of course. The trick is to solve the problem when you
can't avoid it. :-)

                                                        +-DLS

