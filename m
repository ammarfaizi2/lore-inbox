Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWAHLSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWAHLSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWAHLSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:18:09 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:13276 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964902AbWAHLSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:18:08 -0500
From: Grant Coady <gcoady@gmail.com>
To: be-news06@lina.inka.de (Bernd Eckenfels)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Sun, 08 Jan 2006 22:18:03 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de>
In-Reply-To: <E1EvXi5-0000kv-00@calista.inka.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2006 11:23:37 +0100, be-news06@lina.inka.de (Bernd Eckenfels) wrote:

>Willy Tarreau <willy@w.ods.org> wrote:
>> It's rather strange that 2.6 *eats* CPU apparently doing nothing !
>
>it eats it in high interrupt load. And it is caused by the pty-ssh-tcp
>output, so most likely those are eepro100 interrupts.

That would be true for either 2.4 or 2.6, no?  Also it runs e100 
driver, but...

2.4 dmesg:
Intel(R) PRO/100 Network Driver - version 2.3.43-k1
Copyright (c) 2004 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

2.6 dmesg:
[   31.977945] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
[   31.978007] e100: Copyright(c) 1999-2005 Intel Corporation
[   32.002928] e100: eth0: e100_probe: addr 0xfd201000, irq 11, MAC addr 00:90:27:42:AA:77
[   32.026992] e100: eth1: e100_probe: addr 0xfd200000, irq 12, MAC addr 00:90:27:58:32:D4
[   32.186941] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

Are rx checksums not turned on in 2.6' e100 driver?
CPU is only pentium/mmx 233

-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
