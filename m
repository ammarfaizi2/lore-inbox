Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263328AbTC2AdL>; Fri, 28 Mar 2003 19:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbTC2AdL>; Fri, 28 Mar 2003 19:33:11 -0500
Received: from [12.47.58.223] ([12.47.58.223]:39572 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263328AbTC2AdK>; Fri, 28 Mar 2003 19:33:10 -0500
Date: Fri, 28 Mar 2003 16:44:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-Id: <20030328164419.0fe82430.akpm@digeo.com>
In-Reply-To: <1048897765.601.5.camel@teapot>
References: <20030328145159.GA4265@werewolf.able.es>
	<20030328124832.44243f83.akpm@digeo.com>
	<20030328230510.GA5124@werewolf.able.es>
	<1048897765.601.5.camel@teapot>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2003 00:44:20.0625 (UTC) FILETIME=[55F6A810:01C2F58C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> I had exactly the same issue as you, but this time it was on my laptop
> when using a 3CCFE575CT CardBus 10/100 NIC.

Don't think so.  You were getting 0xff when reading all PCI registers.  In
this case it is only the MAC address (which comes from an external eeprom)
which is coming up as 0xff.

0xff in the PCI regisers is a PCI setup problem, 0xff in the eeprom is a
power management problem.

(But the PCI IDs are read out of the eeprom into the PCI interface hardware
by the hardware.  So the EEPROM must have been powered up and down again at
some point.)

