Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268038AbUHFAmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268038AbUHFAmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHFAmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:42:46 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:61950 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S268034AbUHFAmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:42:03 -0400
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Thu, 5 Aug 2004 19:41:50 -0500 (CDT)
Message-Id: <200408060041.i760fn60000117668@mudpuddle.cs.wustl.edu>
To: marcelo.tosatti@cyclades.com, wli@holomorphy.com
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Cc: berkley@cse.wustl.edu, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I took the 2.6.6-bk7 image, and replaced mm/readahead.c and mm/vmscan.c
from the 2.6.6-bk6 image (just those two files), and the read ahead error
has vanished. However, the kernel panic'ed when reading a 16gb file.
It may be related to an ongoing issue with pci-x and scsi error recovery
on the x86_64, so until I get into the office, I will not be able
to see what's on the console. 
	So clearly the code in readahead.c and vmscan.c in -bk7 is
the source of one regression. I'll keep looking at the second bug
in the morning.
	Thanks to all for the pointers on where to look.

berkley
