Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSKUUwN>; Thu, 21 Nov 2002 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbSKUUwN>; Thu, 21 Nov 2002 15:52:13 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13448 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264730AbSKUUwK>; Thu, 21 Nov 2002 15:52:10 -0500
Subject: Re: Setting MAC address in ewrk3 driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Cafferkey <caffer@cs.ucc.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121195417.A18859@cuc.ucc.ie>
References: <20021121195417.A18859@cuc.ucc.ie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 21:28:15 +0000
Message-Id: <1037914095.9122.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 19:54, Neil Cafferkey wrote:
> Hi,
> 
> I think I may have found a bug in the ewrk3 network driver. When I try to
> change the MAC address of a Digital DE205 NIC using "ifconfig eth0 hw
> ether XX:XX:XX:XX:XX:XX", it appears to work ("ifconfig eth0" reports the
> new address), but in fact it isn't sending or receiving packets any more.
> I'm using kernel version 2.4.10.

The default handler assumes the card mac address is set by the "up"
method. That driver is old enough it may not do so.

