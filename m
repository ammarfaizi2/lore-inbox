Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTFBEmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTFBEmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:42:45 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:50438 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S261827AbTFBEmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:42:44 -0400
Message-ID: <3EDAD8AA.50503@interlog.com>
Date: Mon, 02 Jun 2003 14:55:06 +1000
From: Douglas Gilbert <dgilbert@interlog.com>
Reply-To: dgilbert@interlog.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, agusmdp@hotmail.com
Subject: Re: Problems with scsi emulation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm using a customized 2.4.20 kernel (red hat 9) with
 > scsi emulation, scsi  cdrom & scsi generic support
 > options enabled in .config and hdx-ide-scsi in
 > lilo.conf. apps as cdrecord or cdrdao take up all my
 > cpu time (I have a duron 1.1 gz, kt133, 192mb sdram,
 > 30 gb 5400 rpm hd). in windows (with dma enabled) Nero d
 > oesn't take up any (or almost) cpu time...
 > is this an issue of the linux-kernel or a configuration
 > problem?

Due to many problems with DMA locking up on ATAPI writers
earlier in the lk 2.4 series, Linux takes a very
conservative approach and turns off DMA.
It can be turned back on with:
  # hdparm -d 1 /dev/hdb
assuming your cdwriter is found at /dev/hdb (even
though the ide-scsi driver "owns" that device
and you address it as /dev/scd0 ). You can get
faster DMA modes with the addition of the "-X"
switch in hdparm but that should not be necessary.

Doug Gilbert

