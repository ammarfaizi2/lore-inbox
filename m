Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUASOVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUASOVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:21:05 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:65036 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265119AbUASOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:21:00 -0500
Date: Mon, 19 Jan 2004 23:21:31 +0900 (JST)
Message-Id: <20040119.232131.03582632.yoshfuji@linux-ipv6.org>
To: marcel@holtmann.org
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Problem with CONFIG_SYSCTL disabled
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1074521369.6070.99.camel@pegasus>
References: <1074519043.6070.93.camel@pegasus>
	<20040119.224603.71004956.yoshfuji@linux-ipv6.org>
	<1074521369.6070.99.camel@pegasus>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1074521369.6070.99.camel@pegasus> (at Mon, 19 Jan 2004 15:09:29 +0100), Marcel Holtmann <marcel@holtmann.org> says:

> so it is not needed to wrap the inclusion of linux/sysctl.h around
> #ifdef's, but why is it done so many times?
> 
> 	net/core/neighbour.c
> 	net/ipv4/devinet.c
> 	net/ipv4/arp.c
> 	net/ipv4/route.c
> 	net/ipv4/netfilter/ip_conntrack_standalone.c
> 	net/ipv6/route.c
> 	net/ipv6/addrconf.c
> 	net/ipv6/ndisc.c
> 	net/ipv6/icmp.c
> 	net/appletalk/sysctl_net_atalk.c
> 	net/bridge/br_netfilter.c

Compilation time?

If one does not require linux/sysctl.h without CONFIG_SYSCTL,
you don't need to include it.

--yoshfuji

