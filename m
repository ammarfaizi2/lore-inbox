Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318321AbSGWUxj>; Tue, 23 Jul 2002 16:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318322AbSGWUxj>; Tue, 23 Jul 2002 16:53:39 -0400
Received: from zion.devzone.ch ([212.254.206.211]:6807 "EHLO zion.devzone.ch")
	by vger.kernel.org with ESMTP id <S318321AbSGWUxh>;
	Tue, 23 Jul 2002 16:53:37 -0400
Message-ID: <32868.80.218.9.155.1027457806.squirrel@www.devzone.ch>
Date: Tue, 23 Jul 2002 22:56:46 +0200 (CEST)
Subject: 2.4.19-rc3 incorrectly detects PDC20276 in ATA mode as raid controller 
From: "Daniel Tschan" <tschan+linux-kernel@devzone.ch>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Kernel 2.4.19-rc3 introduces a new bug regarding the Promise PDC20276
controller. One of my machines has a Gigabyte GA-8IRXP Motherboard with an
onboard Promise PDC20276. The controller can either be run in RAID or in
ATA mode. I operate it in ATA mode. Kernel 2.4.19-rc3 now incorrectly
skips IDE initialization of the PDC20276 because it thinks it's a RAID
controller which results in a kernel panic (the root filesystem is on a
harddisk connected to the Promise controller). It outputs a message like
this before it panics: PDC20276: Skipping RAID controller. This worked
correctly in 2.4.19-rc2.

Regards
Daniel



