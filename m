Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTELATk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTELATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:19:40 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:19586 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261568AbTELATj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:19:39 -0400
Subject: eth0: Too much work in interrupt, status e401
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052699512.662.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 12 May 2003 02:31:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having severe hardlocks with 2.5.69-mm3 when mounting an NFS volume
from one of my NFS servers. I think this is related to iptables, but
while investigating, I found the following messages on my dmesg ring:

spurious 8259A interrupt: IRQ7.
eth0: Setting full-duplex based on MII #0 link partner capability of
01e1.
eth0: Transmit error, Tx status register 90.
  Flags; bus-master 1, dirty 923(11) current 927(15)
  Transmit list 0f37f980 vs. cf37f8e0.
  0: @cf37f200  length 80000036 status 00010036
  1: @cf37f2a0  length 80000036 status 00010036
  2: @cf37f340  length 80000036 status 00010036
  3: @cf37f3e0  length 80000036 status 00010036
  4: @cf37f480  length 80000036 status 00010036
  5: @cf37f520  length 80000036 status 00010036
  6: @cf37f5c0  length 80000036 status 00010036
  7: @cf37f660  length 80000036 status 00010036
  8: @cf37f700  length 80000036 status 80010036
  9: @cf37f7a0  length 80000036 status 00010036
  10: @cf37f840  length 80000036 status 00010036
  11: @cf37f8e0  length 80000036 status 00010036
  12: @cf37f980  length 80000036 status 00000036
  13: @cf37fa20  length 80000036 status 00000036
  14: @cf37fac0  length 80000036 status 80000036
  15: @cf37fb60  length 80000036 status 00010036
eth0: Too much work in interrupt, status e401.

I have no idea what does this mean...

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

