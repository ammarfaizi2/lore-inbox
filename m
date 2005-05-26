Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVEZBcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVEZBcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVEZBcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:32:46 -0400
Received: from pop.gmx.de ([213.165.64.20]:53992 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261647AbVEZBco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:32:44 -0400
X-Authenticated: #14640924
Message-ID: <015201c56193$ae5f86f0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: query, which io scheduler is active?
Date: Thu, 26 May 2005 03:38:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

dmesg tells:

---snip---
Kernel command line: root=/dev/sda2 
---snip---
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
---snip---

ok - there are 4 types of io schedulers - but - how can one see/query, which i/o scheduler is the currently "active" one?

It seems that SuSE Kernel shows this via

if (!printed) {
                printed = 1;
                printk("Using %s io scheduler\n", chosen_elevator->elevator_name);
        }

in drivers/block/ll_rw_blk.c

I can supply a patch if you like.

regards
roland



