Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUHQOHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUHQOHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUHQOHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:07:41 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:57242 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266236AbUHQOG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:06:56 -0400
Subject: RE: Can not read UDF CD
From: Pat LaVarre <p.lavarre@ieee.org>
To: David Balazic <david.balazic@hermes.si>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090209@piramida.hermes.si>
References: <B1ECE240295BB146BAF3A94E00F2DBFF090209@piramida.hermes.si>
Content-Type: text/plain
Organization: 
Message-Id: <1092751541.4934.59.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Aug 2004 08:05:41 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2004 14:06:53.0274 (UTC) FILETIME=[729D0BA0:01
	C48463]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:6.34492 C:20 M:0 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic:

Sorry I still have Not caught up on all this thread, yet I can add:

> How should I make the image ?
> Remember, it is a multisession CD ( has two sessions ).

I'm curious to know how you answered that question, because:

> http://bitconjurer.org/BitTorrent/download.html
> http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent
> http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports/udf.iso

I see this UDF disc image did Not arrive here in a usable form:

$ logger 1
$ sudo mount -r -t udf -o loop=/dev/loop0 udf.iso /mnt/loop0
mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       or too many mounted file systems
       (could this be the IDE device where you in fact use
       ide-scsi so that sr0 or sda or so is needed?)
$ sudo cat /var/log/messages | tail -2
Aug 17 07:48:20 patlinux pat: 1
Aug 17 07:48:25 patlinux kernel: UDF-fs: No partition found (1)
$
$ phgfsck | head -4 | tail -2
Application version: 1.1r0
UCT Core version   : 1.1r0
$ dd if=udf.iso bs=2K conv=sync >udf.2Ki.iso
$ phgfsck -mlimit 99 udf.2Ki.iso | grep 'total o'
    Error count:  11    total occurrences:    43
  Warning count:   0    total occurrences:     0
$
$ md5sum *.iso
22ab5c118f73307f88c43a820ced4718  udf.2Ki.iso
03ef2c1d988f65acde82c5da40ef17a2  udf.iso
$

> > I still have Not caught up on all this thread

I haven't yet seen you report uname -msr of 2.6.7 or better.

I missed how Ben F's suggestion of mount -t udf -o session=$n worked
out.

The David Burg & Gerrit S input I have not processed.

Etc.

> http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports/udf.iso

Link rotted away by now, I think.

Pat LaVarre
http://sourceforge.net/tracker/index.php?func=detail&aid=1008156&group_id=295&atid=100295
http://linux-pel.blog-city.com/read/768572.htm
http://linux-pel.blog-city.com/read/776884.htm


