Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEUIiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTEUIiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:38:21 -0400
Received: from tag.witbe.net ([81.88.96.48]:51212 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261603AbTEUIiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:38:20 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: e100 latency, cpu cycle saver and e1000...
Date: Wed, 21 May 2003 10:51:21 +0200
Message-ID: <00e701c31f76$26fea350$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few days ago, there was a thread about e100 latency related to
CPU Cycle Saver...

Suggestion was to disabled it to return back to some "standard"
latency.

At the moment, I'm experiencing some strange behavior, not with
an e100 but with an e1000 on a 2.4.20 kernel...

Here are some traces, using Corey Minyard test application :

[root@IP3 tmp]# ./test IP1 32000 10000 370
Average: 201us, Max: 631us, Min: 200us
[root@IP3 tmp]# ./test IP2 32000 10000 370
Average: 422us, Max: 47581us, Min: 209us

All three machines are using 2.4.20 and e1000 drivers, they are
the same hardware.

But, definitely, IP2 is exhibiting much higher max latency...

Increasing the packet size up to 1200 bytes doesn't change the 
global behavior : IP2 is always much "latent" than IP1...

The problem is that it seems there is no CPU Cycle Saver on e1000
NIC. Is there some equivalent ? Could someone give a guess on
what's going on ?

Regards,
Paul

