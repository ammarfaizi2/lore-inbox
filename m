Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVCWFwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVCWFwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVCWFwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:52:54 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:7610 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262796AbVCWFwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:52:51 -0500
Date: Tue, 22 Mar 2005 21:52:43 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.x wireless update and status
Message-ID: <20050323055243.GU8648@jm.kir.nu>
References: <4240CA69.9020902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4240CA69.9020902@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 08:46:17PM -0500, Jeff Garzik wrote:

> Just updated the wireless-2.6 queue to include a HostAP update, and to 
> add Wireless Extensions 18 (WPA).  See attached for BK info, patch info, 
> and changelog.

Thanks!

> Moving forward, the next "todo" for kernel wireless hackers is to get 
> ieee80211 common code lib into shape, namely:
> * Merge Intel ipw drivers, which use ieee80211
> * Update HostAP to use ieee80211
> * Merge/convert other drivers to use ieee80211?

I'll be working on HostAP driver next; and ieee80211 code of course at
the same time, since it is likely to need some changes for this. As far
as other drivers are concerned, I'd like to see Atheros cards working
with the generic ieee80211 code. They would be a good test target since
they are an example of design where very large part of functionality is
in the driver/network stack (no firmware used). This would be a good
test to verify that the 802.11 code is generic enough for such a design.

> There is one minor point of contention so far.  Jouni stated he prefers 
> that HostAP go upstream before it gets updated to use ieee80211.  I 
> respectfully disagree, and prefer that HostAP is updated -first- to use 
> the ieee80211 lib, before going upstream.

I think we can resolve this quite easily. The main reason for the other
order was in trying to save my time by not having to work in more than
one active development tree at the same time. This is kind of required
since designing and maintaining an IEEE 802.11 stack would really be a
full-time job and unfortunately, I have not yet managed to reach this
goal in a way that would allow me to use all my time on open source
development.

BK did not really work that well for me, but it looks like I'm having
better luck with quilt as far as the amount of time needed for
organizing changes to wireless-2.6 is concerned. In addition, the total
number of changes to the driver code has been quite small lately, so I'm
beginning to be more open to moving all future development into
wireless-2.6 tree and just keeping my current CVS repository as a
backwards compatible (2.2/2.4/2.6 kernels), stable version that wouldn't
get any more new features. This would allow the order that you prefer.
In addition, if someone really wants to get the new features I may be
adding, these should be available through wireless-2.6 tree (and -mm for
that matter).

-- 
Jouni Malinen                                            PGP id EFC895FA
