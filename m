Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWHDDY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWHDDY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHDDY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:24:28 -0400
Received: from thunk.org ([69.25.196.29]:59095 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751420AbWHDDY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:24:27 -0400
Date: Thu, 3 Aug 2006 23:23:49 -0400
From: Theodore Tso <tytso@mit.edu>
To: Michael Chan <mchan@broadcom.com>
Cc: David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060804032348.GA16313@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Michael Chan <mchan@broadcom.com>,
	David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au> <1154630207.3117.17.camel@rh4> <20060803201741.GA7894@thunk.org> <20060803.144845.66061203.davem@davemloft.net> <1154647699.3117.26.camel@rh4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154647699.3117.26.camel@rh4>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:28:19PM -0700, Michael Chan wrote:
> True.  But they also have ASF enabled which requires tg3_timer() to send
> the heartbeat periodically.  If the heartbeat is late, ASF may reset the
> chip believing that the system has crashed.

Parden me for asking a dumb question, but what's being accomplished by
resetting the chip if the system has crashed?  Why not reset the chip
when the system reboots and it sees the PCI bus reset?  I guess I'm
missing the purpose of the ASF heartbeat; why does the networking chip
need a chip-specific watchdog?

						- Ted
