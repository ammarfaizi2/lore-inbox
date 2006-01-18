Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWARFvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWARFvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWARFvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:51:35 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28874
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751340AbWARFve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:51:34 -0500
Date: Tue, 17 Jan 2006 21:47:50 -0800 (PST)
Message-Id: <20060117.214750.37718950.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net 2.6.16-rc1: multiple ipv6 failures
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43CDAA58.5000904@pobox.com>
References: <43CDAA58.5000904@pobox.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Tue, 17 Jan 2006 21:39:20 -0500

> 2) bind fails (which everyone on my network immediately noticed, and
> complained about).
> 
> > Jan 17 21:29:04 pretzel named[5110]: loading configuration from '/etc/named.conf'
> > Jan 17 21:29:04 pretzel named[5110]: /proc/net/if_inet6:sscanf() -> 1 (expected 6)
> > Jan 17 21:29:04 pretzel named[5110]: interfacemgr.c:827: unexpected error:
> > Jan 17 21:29:04 pretzel named[5110]: interface iteration failed: failure
> > Jan 17 21:29:04 pretzel named[5110]: not listening on any interfaces
> > Jan 17 21:29:04 pretzel named[5110]: command channel listening on 127.0.0.1#953
> > Jan 17 21:29:04 pretzel named[5110]: /proc/net/if_inet6:sscanf() -> 1 (expected 6)
> > Jan 17 21:29:04 pretzel named[5110]: interfacemgr.c:827: unexpected error:
> > Jan 17 21:29:04 pretzel named[5110]: interface iteration failed: failure

Known problem, fixed by Yoshifuji in current GIT.  /proc/net/if_net6's
output format got mistakedly changed, and this confused named and
ifconfig, among other things.
