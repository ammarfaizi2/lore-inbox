Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUBSUEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUBSUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:04:32 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:13454 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S267516AbUBSUE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:04:29 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2004 20:04:27 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <403516CB.22343.57A7D52@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, corrected (and as the kernel was built):
> 
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=y
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_8139_RXBUF_IDX=2

OK, I think there _is_ a problem here.  I was suspecting my NFS setup 
maybe causing the NIC (eth0) to timeout and get reset, as I mount 
files from an old 486 -> 2.6.3 box.

But after messing about a bit, I checked the logs on my 2.4.24 box 
via SSH (AND eth1).  It hung as issued #> pico /var/log/messages  for 
about 3 seconds.. then came to life.  So...

... in the logs on 2.6.3 box straight after:

Feb 19 19:33:13 Linux233 kernel: NETDEV WATCHDOG: eth1: transmit 
timed out
Feb 19 19:33:13 Linux233 kernel: eth1: link up, 10Mbps, half-duplex, 
lpa 0x0000

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

