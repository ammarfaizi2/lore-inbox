Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVITRNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVITRNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVITRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:13:18 -0400
Received: from smtp.texramp.net ([209.144.20.28]:38928 "EHLO smtp.texramp.net")
	by vger.kernel.org with ESMTP id S964783AbVITRNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:13:17 -0400
From: Charles McCreary <mccreary@crmeng.com>
To: linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Date: Tue, 20 Sep 2005 12:12:55 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201212.55676.mccreary@crmeng.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another datapoint for this thread. The box spewing the bad pmds messages is a 
dual opteron 246 on a TYAN S2885 Thunder K8W motherboard. Kernel is 
2.6.11.4-20a-smp.

Approximately one hour after the bad pmd's, the box was completely 
unresponsive. This machine is either idle or heavily loaded, many threads, 
lots of io and nfs network traffic. Never see this when idle. When heavily 
loaded, it will invariably become unresponsive within 24 hrs. Looks 
reproducible. I'm willing to provide more information and test patches.

Output:
Sep 15 06:42:46 lakeport -- MARK --
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680bc8
(00002aaaaaaaba98).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680bd0
(0000000000000002).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680bd8
(00007ffffffffdcc).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680be0
(00007ffffffffdcd).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680bf0
(00007ffffffffdce).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680bf8
(00007ffffffffdcf).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c00
(00007ffffffffdd0).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c08
(00007ffffffffdd1).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c10
(00007ffffffffdd2).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c18
(00007ffffffffdd3).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c20
(00007ffffffffdd4).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c28
(00007ffffffffdd5).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c30
(00007ffffffffdd6).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c38
(00007ffffffffdd7).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c40
(00007ffffffffdd8).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c48
(00007ffffffffdd9).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c50
(00007ffffffffdda).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c58
(00007ffffffffddb).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c60
(00007ffffffffddc).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c68
(00007ffffffffddd).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c70
(00007ffffffffdde).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c78
(00007ffffffffddf).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c80
(00007ffffffffde0).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c88
(00007ffffffffde1).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c90
(00007ffffffffde2).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680c98
(00007ffffffffde3).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680ca0
(00007ffffffffde4).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680ca8
(00007ffffffffde5).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cb0
(00007ffffffffde6).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cc0
(0000000000000010).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cc8
(00000000078bfbff).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cd0
(0000000000000006).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cd8
(0000000000001000).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680ce0
(0000000000000011).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680ce8
(0000000000000064).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cf0
(0000000000000003).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680cf8
(0000000000400040).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d00
(0000000000000004).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d08
(0000000000000038).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d10
(0000000000000005).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d18
(0000000000000009).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d20
(0000000000000007).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d28
(00002aaaaaaab000).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d30
(0000000000000008).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d40
(0000000000000009).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d48
(00000000004010f0).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d50
(000000000000000b).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d60
(000000000000000c).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d70
(000000000000000d).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d80
(000000000000000e).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680d90
(0000000000000017).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680da0
(000000000000000f).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680da8
(00007ffffffffdc5).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680dc0
(3638780000000000).
Sep 15 06:58:44 lakeport kernel: mm/memory.c:97: bad pmd ffff81013c680dc8
(000000000034365f).
Sep 15 07:22:47 lakeport -- MARK --

