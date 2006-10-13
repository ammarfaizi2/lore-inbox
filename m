Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWJMMKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWJMMKI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWJMMKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:10:08 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:52143 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751638AbWJMMKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:10:07 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: Current kernels break libdvdcss
Date: Fri, 13 Oct 2006 14:08:53 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131408.53826.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-mm3 and 2.6.19-rc1-mm1 break playing encrypted video DVDs with 
libdvdcss based players.

The player just says it can't open /dev/dvd with libdvdcss; after that, dmesg 
points out

hdX: read_intr: Drive wants to transfer data the wrong way!

(hdX is hdb or hdc, depending on where the drive is connected).
This is reproducable on at least 3 different machines with different IDE 
controllers and CD drives.

Has there been any intentional change that would require modifications in 
libdvdcss?

Last known good kernel is 2.6.18-rc2-mm1 (didn't keep binaries for those in 
between and I'm confined to abysmally slow compile machines at the moment).
