Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUDTWuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUDTWuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbUDTWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:49:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:21705 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264373AbUDTWiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:38:55 -0400
X-Authenticated: #271361
Date: Wed, 21 Apr 2004 00:38:45 +0200
From: Edgar Toernig <froese@gmx.de>
To: Nick Popoff <cryptic-lkml@bloodletting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing Dual Ethernet via Loopback
Message-Id: <20040421003845.05c44356.froese@gmx.de>
In-Reply-To: <200404190614.21764.cryptic-lkml@bloodletting.com>
References: <200404190614.21764.cryptic-lkml@bloodletting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Popoff wrote:
>
> So what I'm wondering is if there is a way to force Linux to actually
> utilize its network hardware in sending these packets to itself?  In other
> words, a ping or file transfer from an IP assigned to eth0 to another IP
> assigned to eth1 should fail if I unplug the network cable connecting the
> two.  Any advice on this would be much appreciated.

I don't know if there's some knob for that.  What I'm always doing:
tcpdump on one interface and then a broadcast ping on the other one.

If you want to write a hardware test program maybe using raw ethernet
packets is the way to go.  These can be send directly to a specific
interface and don't require it to be IP-configured.  man 7 packet

Ciao, ET.
