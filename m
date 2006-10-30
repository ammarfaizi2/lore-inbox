Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWJ3NDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWJ3NDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWJ3NDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:03:03 -0500
Received: from main.gmane.org ([80.91.229.2]:4833 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964817AbWJ3NDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:03:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Date: Mon, 30 Oct 2006 13:02:23 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekbubl.2vm.olecom@flower.upol.cz>
References: <Pine.LNX.4.64.0610291211160.25218@g5.osdl.org> <20061029223410.GA15413@electric-eye.fr.zoreil.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Francois Romieu <romieu@fr.zoreil.com>, Linus Torvalds <torvalds@osdl.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Bunk <bunk@stusta.de>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-29, Francois Romieu wrote:
>
> Linus Torvalds <torvalds@osdl.org> :
> [regression related to r8169 MAC address change]
>> Francois ? Jeff ?
>
> Go revert it.
>
> Despite what I claimed, I can not find a third-party confirmation by email
> that it works elsewhere.

It works for me:
,--
|root@flower:/home/olecom# ip l set eth0 addr 00:00:00:00:00:02
|root@flower:/home/olecom# ip l set eth0 addr 00:00:00:00:00:03
|root@flower:/home/olecom# ip l set eth0 addr 00:00:00:00:00:04
|root@flower:/home/olecom# ip l set eth0 addr 04:44:44:44:44:04
|root@flower:/home/olecom# ip l show
|1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
|    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
|    2: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 1000
|    link/ether 04:44:44:44:44:04 brd ff:ff:ff:ff:ff:ff
|root@flower:/home/olecom# lspci -v | grep Realtek
|    02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
|RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
|root@flower:/home/olecom#
|root@flower:/home/olecom# uname -a
|Linux flower 2.6.19-rc2-vanilla-ai #4 SMP PREEMPT Tue Oct 17 02:19:16
|UTC 2006 x86_64 GNU/Linux
|root@flower:/home/olecom#
`--
____

