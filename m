Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTJJMxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJJMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:53:34 -0400
Received: from mail.atr.bydgoszcz.pl ([212.122.192.35]:38836 "EHLO
	mail.atr.bydgoszcz.pl") by vger.kernel.org with ESMTP
	id S262490AbTJJMxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:53:32 -0400
From: "Adam Flizikowski" <adam_fli@poczta.onet.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 8139_tx_interrupt - Tx time
Date: Fri, 10 Oct 2003 14:52:13 +0200
Message-ID: <GMEGLMHAELFDACHHIEPIMENLCPAA.adam_fli@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to find out how long it takes to push packet off the NIC in
8139_tx_interrupt(){} (kernel 2.4.20)

but i don't know how to identify packet in this loop - i know that "entry"
stands for the packet but in the loop underneath:
/* code snippet for 8139_tx_interrupt(){}*/

1726         while (tx_left > 0) {
1727                 int entry = dirty_tx % NUM_TX_DESC;
1728                 int txstatus;

...

1762
1763                 dirty_tx++;
1764                 tx_left--;    // <- is single packet sent just
here??????
1765         }

what "tx_left" and "dirty_tx" variables stand for? Is single iteration
through the loop (lines 1726-1765) related to SINGLE packet transmission?

I wanted to put some probes inside tx_interrupt but not sure where it should
start/stop measuring to show single packet transmission time.


regards

adam

