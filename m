Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUJSTZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUJSTZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbUJSTBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:01:03 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:54380 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S269607AbUJSSxk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:53:40 -0400
Date: Tue, 19 Oct 2004 20:53:09 +0200 (CEST)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: unregister_netdevice 2.6.9
In-Reply-To: <20041020.022622.27982693.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.58LT.0410191953390.13480@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.58LT.0410191738420.2725@lt.wsisiz.edu.pl>
 <20041020.022622.27982693.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (portraits.wsisiz.edu.pl [0.0.0.0]); Tue, 19 Oct 2004 20:53:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, YOSHIFUJI Hideaki / ???? wrote:

> > whreis xxxx is name of sit device, created via script
> 
> Is your box acting as router, or host?
> % sysctl -a |grep ipv6|grep forwarding

lt:~# sysctl -a |grep ipv6|grep forwarding
net.ipv6.conf.atman6.forwarding = 0
net.ipv6.conf.eth1.forwarding = 0
net.ipv6.conf.eth0.forwarding = 0
net.ipv6.conf.lo.forwarding = 0
net.ipv6.conf.default.forwarding = 0
net.ipv6.conf.all.forwarding = 0

atman6 is sit device, ipv6 is loaded as module.


> What is happend if you let the interface down and delete it before
> becore rebooting?

OK, if interface is down, system is rebooting correctly.

I had made tests with shutdown interfaces, but i shutdowned wrong sit 
interface. :( Sorry for that. 

Anyway, ipip interfaces no need to be shutdown before reboot. Is it
problem in sit_cleanup()?


-- 
£T
