Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262984AbTCSLVs>; Wed, 19 Mar 2003 06:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTCSLVs>; Wed, 19 Mar 2003 06:21:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:62390 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262984AbTCSLVr>;
	Wed, 19 Mar 2003 06:21:47 -0500
Date: Wed, 19 Mar 2003 03:32:35 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1: eth0: Transmit error, Tx status register 90
Message-Id: <20030319033235.4fbc9b20.akpm@digeo.com>
In-Reply-To: <20030319112443.16070.qmail@linuxmail.org>
References: <20030319112443.16070.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 11:32:35.0828 (UTC) FILETIME=[3D2E2340:01C2EE0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> So it seems a problem with the network transport.

yes, it's a network problem.

> This doesn't 
> happen with 2.4 on the same hardware: NEC Chrom@ laptop, 
> TI CardBus bridge, 3Com Corporation 3CCFE575CT Cyclone 
> CardBus (rev 10) NIC. 

Ah.   You're using cardbus.  Please send lspci output.

> Now, what else? I'm lost... 

The NIC driver is basically unchanged from 2.4.  It will be a
cardbus/PCI/northbrige/southbridge setup problem.

Look for suspicious dmesg output.  Compare the `lspci -vvxx' output for 2.5
and 2.4, see if any of the registers look different.  This will be hard.


