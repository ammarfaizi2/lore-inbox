Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTFOKif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFOKie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:38:34 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:38919 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262135AbTFOKic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:38:32 -0400
Date: Sun, 15 Jun 2003 12:45:19 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "David S. Miller" <davem@redhat.com>
Cc: khc@pm.waw.pl, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network hotplug via class_device/kobject
Message-ID: <20030615124519.A11939@electric-eye.fr.zoreil.com>
References: <20030613164119.15209934.shemminger@osdl.org> <20030615.005055.55726223.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615.005055.55726223.davem@redhat.com>; from davem@redhat.com on Sun, Jun 15, 2003 at 12:50:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> :
[rtnl_lock() and register_netdevice()]
>    Paranoid about some driver doing something like:
>    	rtnl_lock(); register_netdevice(); unregister_netdevice(); rtnl_unlock() BOOM
> 
> These sorts of turds exist at least in two places:
> 
> 1) drivers/net/wan/comx.c
> 2) drivers/net/wan/hdlc_fr.c
> 
> But it is pretty clear that these two drivers have been
> tried by nobody in recent years.  They both call into

It's pretty clear but it's false :o)

> {un,}register_netdevice without the RTNL semaphore held.

There is a maintainer for 2):
GENERIC HDLC DRIVER, N2 AND C101 DRIVERS
P:      Krzysztof Halasa
M:      khc@pm.waw.pl
W:      http://hq.pm.waw.pl/hdlc/
S:      Maintained

--
Ueimor
