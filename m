Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263974AbTDJAqf (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 20:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTDJAqf (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 20:46:35 -0400
Received: from pop.gmx.net ([213.165.65.60]:20319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263974AbTDJAqe (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 20:46:34 -0400
From: "Oliver S." <Follow.Me@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: WG: questions regarding Journalling-FSes and w-cache reordering
Date: Thu, 10 Apr 2003 02:58:15 +0200
Message-ID: <001001c2fefc$44ed47d0$0200000a@kimba>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to build a reliable ~1 TB RAID 5 from IDE drives. I will
> gladly give up performance for high reliability and low cost.

 Most ATA-RAIDs disable write-caching, and that's not really a performance
-disadvantage with a decent drive-scheduler (afaik most OSes implement a
cyclical-scan and not elevator-schedulers) when the HD has a linear mapping;
and today's ATA-HDs all have linear mappings. Only with back-to-back writes
can cause the HD to have a lap of honour.

