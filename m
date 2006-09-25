Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWIYIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIYIYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWIYIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:24:48 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:11797 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750777AbWIYIYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:24:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAALMsF0WLcQEBDQ
X-IronPort-AV: i="4.09,211,1157320800"; 
   d="scan'208"; a="3463390:sNHT32261592"
Date: Mon, 25 Sep 2006 10:24:45 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/03] net/bridge: add support for EtherIP devices
Message-ID: <20060925082445.GB23028@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121629.GC32284@zlug.org> <20060923210112.130938ca@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923210112.130938ca@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 09:01:12PM -0700, Stephen Hemminger wrote:

> If the device looks like a duck (Ethernet), then why does it need
> a separate ARP type.  There are other tools that might work without
> modification if it just fully pretended to be an ether device.

This solves the problem of getting a list of all EtherIP devices. If
they use ARPHRD_ETHER and use an ioctl in the SIOCDEVPRIVATE space is
not a save way (not even if the ioctl uses ethip0, this device could be
owned by another driver if EtherIP is not present).
On the other hand, a new ARP type opens a lot of new problems. A lot of
userspace tools and libraries must be changed. So this solutions is not
perfect.

Cheers,
Joerg
