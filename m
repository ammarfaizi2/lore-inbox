Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129787AbQKBWeG>; Thu, 2 Nov 2000 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129919AbQKBWd4>; Thu, 2 Nov 2000 17:33:56 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:17285 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129787AbQKBWdu>; Thu, 2 Nov 2000 17:33:50 -0500
Date: Thu, 2 Nov 2000 17:32:54 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Sample device driver - 2.2 and 2.4 support?
Message-ID: <Pine.LNX.4.30.0011021711120.1544-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been assigned a device driver that uses the old (2.0) PCI
support APIs - and is still working on 2.2.

I need to get this driver working on 2.2 and 2.4, I'm assuming I'll
need to go switch to the newer PCI stuff - but am curious about the
toleration support in later 2.2 kernels; is it complete enough that
I can migrate to 2.4, and still compile on 2.2?

The device:
  1-2 DMA
  1   IRQ

The driver:
  mkalloc
  __get_free_pages
  virt_to_bus
  request_irc
  wake_up

The driver has similiar functionality to a sound card:
  Send/Receive (possibly large) data to device via DMA (page fixing, etc)

Is there a cononical example (esp. wrt 2.2 <-> 2.4 changes) I should look
at ?

Thanks,
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
