Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUHQO0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUHQO0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUHQOZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:25:55 -0400
Received: from guardian.hermes.si ([193.77.5.150]:64006 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S268273AbUHQOZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:25:03 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF09021A@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: RE: Can not read UDF CD
Date: Tue, 17 Aug 2004 16:24:32 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 03ef2c1d988f65acde82c5da40ef17a2  udf.iso
> 
This is the correct md5sum, you have the correct file.

I will create a smaller CD and try a fresh kernel, real soon now ;-)

> ----------
> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> Sent: 	17. avgust 2004 16:05
> To: 	David Balazic
> Cc: 	linux_udf@hpesjro.fc.hp.com; linux-kernel@vger.kernel.org
> Subject: 	RE: Can not read UDF CD
> 
> David Balazic:
> 
> Sorry I still have Not caught up on all this thread, yet I can add:
> 
> > How should I make the image ?
> > Remember, it is a multisession CD ( has two sessions ).
> 
> I'm curious to know how you answered that question, because:
> 
> > http://bitconjurer.org/BitTorrent/download.html
> > http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent
> > http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports/udf.iso
> 
> I see this UDF disc image did Not arrive here in a usable form:
> 
> $ logger 1
> $ sudo mount -r -t udf -o loop=/dev/loop0 udf.iso /mnt/loop0
> mount: wrong fs type, bad option, bad superblock on /dev/loop0,
>        or too many mounted file systems
>        (could this be the IDE device where you in fact use
>        ide-scsi so that sr0 or sda or so is needed?)
> $ sudo cat /var/log/messages | tail -2
> Aug 17 07:48:20 patlinux pat: 1
> Aug 17 07:48:25 patlinux kernel: UDF-fs: No partition found (1)
> $
> $ phgfsck | head -4 | tail -2
> Application version: 1.1r0
> UCT Core version   : 1.1r0
> $ dd if=udf.iso bs=2K conv=sync >udf.2Ki.iso
> $ phgfsck -mlimit 99 udf.2Ki.iso | grep 'total o'
>     Error count:  11    total occurrences:    43
>   Warning count:   0    total occurrences:     0
> $
> $ md5sum *.iso
> 22ab5c118f73307f88c43a820ced4718  udf.2Ki.iso
> 03ef2c1d988f65acde82c5da40ef17a2  udf.iso
> $
> 
> > > I still have Not caught up on all this thread
> 
> I haven't yet seen you report uname -msr of 2.6.7 or better.
> 
> I missed how Ben F's suggestion of mount -t udf -o session=$n worked
> out.
> 
> The David Burg & Gerrit S input I have not processed.
> 
> Etc.
> 
> > http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports/udf.iso
> 
> Link rotted away by now, I think.
> 
> Pat LaVarre
> http://sourceforge.net/tracker/index.php?func=detail&aid=1008156&group_id=
> 295&atid=100295
> http://linux-pel.blog-city.com/read/768572.htm
> http://linux-pel.blog-city.com/read/776884.htm
> 
> 
