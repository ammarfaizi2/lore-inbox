Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTBYDDQ>; Mon, 24 Feb 2003 22:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBYDDQ>; Mon, 24 Feb 2003 22:03:16 -0500
Received: from mx03.covadmail.net ([63.65.120.63]:9660 "HELO
	smtp.covadmail.net") by vger.kernel.org with SMTP
	id <S265243AbTBYDDQ>; Mon, 24 Feb 2003 22:03:16 -0500
Subject: Re: Box freezes if I enable "AMD 76x native power management"
From: Paul Giordano <giordano@covad.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1046142808.24476.42.camel@tyan.crapulence.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 24 Feb 2003 21:13:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just another voice in the crowd...

TYAN 2462 dual 1200MP, and another w/ dual 1900MP
Dual WD100 IDE, seperate channels
Current BIOS 2.13
1GB RAM

I noticed this behavior when I started playing with 2.4.20 and could
never figger it out - went so far as to bring up KGDB and was way down
in the IDE DMA code, scary stuff... Kept scanning LKML and finally found
this gem of a thread...

Ran up a clean, fresh kernel from pre4-ac5, four combos
1) CONFIG_AMD_PM768=Y CONFIG_BLK_DEV_IDEDMA_PCI=y
2) CONFIG_AMD_PM768=m CONFIG_BLK_DEV_IDEDMA_PCI=y
3) CONFIG_AMD_PM768=Y CONFIG_BLK_DEV_IDEDMA_PCI is not set
4) CONFIG_AMD_PM768=m CONFIG_BLK_DEV_IDEDMA_PCI is not set

In cases 1 and 3, hang at boot, pressing the power button frees it up.
In cases 2 and 4, no boot hang, and, at lease for me, no hang when
amd76x_pm module's loaded

So, back to playing - if you need some testing on this board, let me
know - I use one at work and one at home, takes no time at all to gen up
and try things out, and they'll get pretty good exercise.

Regards,
Gio

Please cc: - not subscribed to LKML

