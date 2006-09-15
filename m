Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWIOGhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWIOGhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWIOGhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:37:12 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:56981 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750827AbWIOGhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:37:10 -0400
Date: Fri, 15 Sep 2006 08:36:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sven-Haegar Koch <haegar@sdinet.de>
cc: xixi lii <xixi.limeng@gmail.com>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: UDP question.
In-Reply-To: <Pine.LNX.4.64.0609150129150.21941@mercury.sdinet.de>
Message-ID: <Pine.LNX.4.61.0609150833170.19096@yvahk01.tjqt.qr>
References: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>
 <Pine.LNX.4.64.0609150129150.21941@mercury.sdinet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> bind socket1.network adapter1...
>> bind socket2 network adapter2

> I am not really sure, but I think the bind to an adapter under linux only
> chooses the source ip, not really the adapter used to send the packets.

To explicitly send things through a specific interface, you need to use 
some magic, like PF_RAW. ping for example is one program that will do 
this (-I option).

> Did you check that the two destination ips have routes through different
> interfaces, and not go out through the same one?

One cannot have the same subnet on multiple interfaces, because ARP 
queries will only be sent through the first one. You need br0 (or bond0 
- depending on how you plan to plan your network) to make them one 
interface.


Jan Engelhardt
-- 
