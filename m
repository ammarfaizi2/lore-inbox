Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbRGBXWz>; Mon, 2 Jul 2001 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265473AbRGBXWo>; Mon, 2 Jul 2001 19:22:44 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:16401 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265470AbRGBXW1>; Mon, 2 Jul 2001 19:22:27 -0400
Date: Mon, 2 Jul 2001 18:22:17 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: pte_val(*pte) as lvalue
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my driver, I have this code:

    unsigned long p = pte_val(*pte);

    [set some bits in "p"]

    pte_val(*pte) = p;

This works fine in 2.2, and 2.4 when PAE support is disabled.  When PAE support
is enabled, it doesn't work, because the pte_val macro can no longer be an
lvalue.

What is the accepted way to assign an integer to a pte that works in 2.2 and
2.4?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

