Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDSAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDSAAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDSAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:00:50 -0400
Received: from [212.106.150.180] ([212.106.150.180]:4795 "EHLO
	stardust.clanet.pl") by vger.kernel.org with ESMTP id S261202AbVDSAAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:00:41 -0400
Message-ID: <000501c54472$d23c60e0$41a8cd54@baltazar>
From: =?iso-8859-2?Q?Rados=B3aw_Balcewicz?= <radek@clanet.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 kernel panics and hangs at boot (due to IDE DMA issues?)
Date: Tue, 19 Apr 2005 02:00:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-Antivirus: avast! (VPS 0516-0, 2005-04-18), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've been trying to run Fedora Core 3 on dual P3 machine (Asus P2B-DS board, Intel BX chipset), but every time I try to boot it, it hangs moments after mounting local filesystems. It doesn't really matter if I boot SMP or non-SMP kernel and I've tried several, from 2.6.9 to latest 2.6.11-1 fresh from yum update. All I can do is boot rescue CD and chroot... Only once I got it to spit something that looked like this (sorry, I did not write it down at that time so it's just what I remember):

kernel panic - not syncing: drivers/ide/pci/piix.c:<something>:spin-lock (drivers/ide/ide.c:<something>) already locked by drivers/ide/dma.c

After few hours of trials and errors (and Google help) I finally got it running by adding ide=nodma to boot command line and by changing USE_DMA to =0 in /etc/sysconfig/harddisks. Now it boots every kernel it didn't before, SMP works fine, gcc recompiled kernel sources several time without single core dump, it's just without DMA disk data transfers are down to few MB/sec. Burning DVDs is short of impossible.

>From what I found this is a well-known problem with FC 2 & 3, Suse 9.1 and some other distributions based on recent 2.6 kernels and not-so-new hardware. So far I've failed to properly compile a vanilla 2.6.11.7 kernel (hangs just before INIT) so I can't say anything about that one...  If this is a known problem then please don't flame me. I have been looking for possible solutions and posting here is my last resort at getting one. If someone can just point me to some explanation I'll be on my way. And please do CC to me directly as I have not subscribed...

If this is a new problem then I'll be happy to assist and provide with logs and /proc infromations, it's just I wasn't sure I should include all that if this is perhaps some silly mistake on my behalf...

Looking forward to an answer
Radek

