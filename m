Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTGVQBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 12:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270901AbTGVQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 12:01:17 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:26385 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270800AbTGVQBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 12:01:17 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Limit skb to be less than 64K with TSO
Date: Tue, 22 Jul 2003 09:16:15 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILIEIPCOAA.alan@storlinksemi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am lost at the following situation:

Env:
I am writing driver + smart NIC's firmware.  The smart NIC has limited
memory. It can do checksum and TSO but with 32K max.

Problem:
SKB may be 64K in size when it reaches the driver. I cannot push all 64K to
the NIC to do checksum.  Is there a way to limit the network stack to give
me only 32K or smaller segments?  If I do checksum in the main processor, it
defeats the purpose.

TIA

Alan

