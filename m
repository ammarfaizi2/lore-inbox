Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUH0VNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUH0VNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUH0VIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:08:42 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:24474 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S267726AbUH0VDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:03:35 -0400
Subject: Re: [usb-storage] drivers/block/ub.c #6
From: Pat LaVarre <p.lavarre@ieee.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
In-Reply-To: <20040730035120.30abd121@lembas.zaitcev.lan>
References: <20040730035120.30abd121@lembas.zaitcev.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1093640531.8006.68.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 15:02:12 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Aug 2004 21:03:29.0872 (UTC) FILETIME=[4DE0B500:01
	C48C79]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:31.99031 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Z:

> Date: 30 Jul 2004 04:51:20 -0600
> ...
> I wish this could be somehow limited to flash keys,

I see a 3X drop in thruput, ouch, when I substitute ub.ko for
usb-storage.ko.

Specifically I get 0.5 GB/min from ub.ko, as contrasted with 1.5 GB/min
from usb-storage.ko, in the outside 1 GiB of a particular disc, in three
or more consistent consecutive samples from each.

I knew how to patch to allow bytes/LBA != 512 only because of your
recent answers in [usb-storage].  I took my samples from
linux-2.6.9-rc1-bk2, modprobe'ing .ko built with and without
CONFIG_BLK_DEV_UB.  

> I did not ask LANANA for a major.
> next ...
> add ioctls to burn CDs, and ...

Yes please.

Even DVD-RAM need the ioctl's to pass thru SCSI, for everything
vendor-specific that lies beyond generic read and write.

> dynamic ... udev ...
> ufi.c ... refactoring ...

Pat LaVarre


