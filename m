Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425148AbWLHIHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425148AbWLHIHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425147AbWLHIHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:07:15 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54174
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1425145AbWLHIHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:07:14 -0500
Date: Fri, 08 Dec 2006 00:07:27 -0800 (PST)
Message-Id: <20061208.000727.23014207.davem@davemloft.net>
To: nhorman@tuxdriver.com
Cc: linux-net@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, clalance@redhat.com
Subject: Re: [PATCH] netpoll: make arp replies through netpoll use mac
 address of sender
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061207194553.GB29313@hmsreliant.homelinux.net>
References: <20061207194553.GB29313@hmsreliant.homelinux.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Horman <nhorman@tuxdriver.com>
Date: Thu, 7 Dec 2006 14:45:53 -0500

> Back in 2.4 arp requests that were recevied by netpoll were processed in
> netconsole_receive_skb, where they were responded to using the src mac of the
> request sender.  In the 2.6 kernel arp_reply is responsible for this function,
> but instead of using the src mac address of the incomming request, the stored
> mac address that was registered for the netconsole application is used.  While
> this is usually ok, it can lead to failures in netpoll in some situations
> (specifically situations where a network may have two gateways, as arp requests
> from one may be responded to using the mac address of the other).  This patch
> reverts the behavior to what we had in 2.4, in which all arp requests are sent
> back using the src address of the request sender.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

Applied, and I'll push this to -stable, thanks Neil.

But please submit networking patches next time to
netdev@vger.kernel.org, most of the networking developers did not see
this patch because you sent it to the user help list (linux-net)
instead of the developer list (netdev).

Thanks again.
