Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752480AbWAFRDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbWAFRDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbWAFRDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:03:24 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:58070 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751190AbWAFRDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:03:23 -0500
Message-ID: <43BEA2B2.7060104@candelatech.com>
Date: Fri, 06 Jan 2006 09:02:42 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
References: <1136541243.4037.18.camel@localhost> <200601061200.59376.mbuesch@freenet.de>
In-Reply-To: <200601061200.59376.mbuesch@freenet.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:

> How would the virtual interfaces look like? That is quite easy to answer.
> They are net_devices, as they transfer data.
> They should probaly _not_ be on top of the ethernet, as 80211 does not
> have very much in common with ethernet. Basically they share the same
> MAC address format. Does someone have another thing, which he thinks
> is shared?

If you can make the virtual devices look like ethernet, I believe a lot of other things
will just work w/out hacking, including user-space apps that think they
know exactly what an ethernet frame/device looks like.

The only things I think of that won't work like ethernet is the ability to
change the local MAC address or go into promisc mode.  And, it's always possible
that future wifi hardware will support that as well.  Either way, the current
API handles this fine:  the requests to change will just fail with a convenient error.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

