Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUFSPax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUFSPax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUFSPax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:30:53 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:17446 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S264002AbUFSPav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:30:51 -0400
Date: Sat, 19 Jun 2004 15:30:48 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SATA performance drop in 2.6.7
Message-Id: <Pine.LNX.4.58.0406191508190.8090@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Anybody noticed that with 2.6.7 the performance of SATA disks
drops drastically. Right after a boot I get the following with
hdparm:

 Timing buffer-cache reads:   3724 MB in  2.00 seconds = 1861.35 MB/sec
 Timing buffered disk reads:  166 MB in  3.03 seconds =  54.72 MB/sec

It then starts to degrate rapidly:

 Timing buffer-cache reads:   2560 MB in  2.00 seconds = 1280.19 MB/sec
 Timing buffered disk reads:  166 MB in  3.01 seconds =  55.14 MB/sec

 Timing buffer-cache reads:   2164 MB in  2.00 seconds = 1081.08 MB/sec
 Timing buffered disk reads:  166 MB in  3.02 seconds =  55.05 MB/sec

 Timing buffer-cache reads:   1700 MB in  2.00 seconds = 850.13 MB/sec
 Timing buffered disk reads:  146 MB in  3.04 seconds =  48.07 MB/sec

Then about 3 minutes after boot it stays at approx.

  Timing buffer-cache reads:   780 MB in  2.00 seconds = 389.67 MB/sec
  Timing buffered disk reads:  102 MB in  3.01 seconds =  33.89 MB/sec

Controller is a Intel ICH5R and disk is Seagate ST380013AS. With kernel
2.6.6 this does not happen. On another PATA system with 2.6.7 this
does not happen, so I assume the problem must be with SATA.

Holger

PS: Please CC me since I am not subscribed.
