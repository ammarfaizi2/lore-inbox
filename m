Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBLPfm>; Wed, 12 Feb 2003 10:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPe2>; Wed, 12 Feb 2003 10:34:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47488
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267260AbTBLPeW>; Wed, 12 Feb 2003 10:34:22 -0500
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0302121509481.1173-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0302121509481.1173-100000@pcgl.dsa-ac.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045068254.2166.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Feb 2003 16:44:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 14:49, Guennadi Liakhovetski wrote:
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }

This is it rejecting a command at start up, thats ok. I do need to
quieten these further yet.

> hda: 31488 sectors (16 MB) w/1KiB Cache, CHS=246/4/32, BUG <=============

Curious. I'll tae a look

> then, on mounting root again
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: Write Cache FAILED Flushing!

For some reason we decided the drive support cache flush. However it
apparently doesnt

> And then these errors appear again on some disk-opoerations, e.g. when
> running lilo, doing dd if=/dev/hda, and some others (raw access?). Can
> this errors be disk-specific? (it's a SiliconTech disk, reported as
> Hitachi) I can try some others, e.g. SunDisk.
> 

I would be interested to see how they compare

