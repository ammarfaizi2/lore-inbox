Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270916AbTGQUlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270920AbTGQUla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:41:30 -0400
Received: from fusilli.4news.com.br ([200.246.225.77]:63114 "EHLO
	fusilli.alltv.com.br") by vger.kernel.org with ESMTP
	id S270916AbTGQUkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:40:42 -0400
Subject: Filesystem corruption? (i7505 chipset, RAID5)
From: Cesar Suga <sartre@linuxbr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058452916.2794.18.camel@sartre.alltv.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 11:41:56 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	In these days I've bought a Tyan i7505 board with a single Xeon
processor. I noticed its GART would only be supported in 2.5.53. So I
compiled 2.5.75 and everything was okay. (Hyperthreading on)

	I have five SCSI HDDs in an Adaptec AHA-2940UW card in RAID5 (software,
obviously), one as a spare disk. /dev/md0 had an ext3 partition. The
graphics card is a Radeon 9000 Pro (64M). X 4.3.0. 1024M system memory.
No devfs compiled. EtherExpress Pro/100 onboard card.

	Rebooting the system with the new 2.6.0-test1 kernel was okay after
replacing 2.5.75. After starting X, I noticed the CPU usage was at 100%.
I switched to a terminal and logged. ls itself gave me ext3 errors and
when I switched back to 2.5.75 the array was entirely damaged (could not
repair at all, so I do not have .config to report)

	Would it be something introduced in the sync_fs() fix or something?

	I can give further reports, if needed, installing a distribution in a
separate hard disk.

--
-- Cesar Suga <sartre@linuxbr.com>
--


