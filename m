Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTIPTeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTIPTeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:34:12 -0400
Received: from waste.org ([209.173.204.2]:36249 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262081AbTIPTeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:34:08 -0400
Date: Tue, 16 Sep 2003 14:33:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Ford <david+powerix@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip/ifconfig down/up hangs network, 2.6.0-test5
Message-ID: <20030916193352.GO4489@waste.org>
References: <3F6726EF.7090906@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6726EF.7090906@blue-labs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 11:06:23AM -0400, David Ford wrote:
> eth2: Station identity 001f:0001:0008:000a
> eth2: Looks like a Lucent/Agere firmware version 8.10
> eth2: Ad-hoc demo mode supported
> eth2: IEEE standard IBSS ad-hoc mode supported
> eth2: WEP supported, 104-bit key
> eth2: MAC address 00:02:2D:5C:18:9F
> eth2: Station name "HERMES I"
> eth2: ready
> eth2: index 0x01: Vcc 3.3, irq 9, io 0x0100-0x013f
> eth2: New link status: Connected (0001)
> spurious 8259A interrupt: IRQ7.
> eth2: New link status: Connected (0001)
> 
> If I set this network card down and try to bring it back up, all net 
> device access stalls in D state.  No dmesg, no panics, nadda.

I've seen a similar problem with tg3 in virgin -test5 and with hostap in
-test4-mm5. I believe I read it was due to something failing to
release the rtnl semaphore?

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
