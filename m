Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJBIhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJBIhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:37:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65292 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263264AbTJBIho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:37:44 -0400
Date: Thu, 2 Oct 2003 10:37:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-hfsplus-devel@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] new HFS(+) driver
Message-ID: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a rather big update to the HFS+ driver. It includes now also an 
updated HFS driver. Both drivers use now almost the same btree code and 
the general structure is very similiar, so one day it will be possible to 
merge both drivers. The HFS driver got a major cleanup and a lot of broken 
options were removed, most notably if you want to continue using netatalk 
with this driver, you have to fix netatalk first.

The HFS+ driver has a number of improvements and fixes:
- blocks are now preallocated.
- allocation file is now in the page cache too
- better extent caching
- btrees are now able to grow arbitrarily
- allocation block size can now be larger than a page
- actual fs block size is adjusted to avoid alignment problems
- cdrom session/partition support (note that this is a crutch and has 
  problems)

This is basically the version I'd liked to get merged into 2.6 (minus lots 
of ifdefs and some debug prints). You can find the driver at
http://www.ardistech.com/hfsplus/

bye, Roman

