Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUDWQho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUDWQho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUDWQho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:37:44 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:14783 "EHLO
	mail-relay-3.tiscali.i") by vger.kernel.org with ESMTP
	id S264860AbUDWQhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:37:31 -0400
Date: Fri, 23 Apr 2004 18:28:01 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux_udf@hpesjro.fc.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Unable to read UDF fs on a DVD
Message-ID: <20040423162801.GA5396@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to read a DVD+RW disk with a UDF fs on it. The disk was
created under Windows, using Easy CD Creator (don't know the details).

I can mount (kernel 2.6.5) w/o problems:
root@dreamland:~# mount -t udf -oro /dev/hdc /cdrom

dmesg:
udf: registering filesystem
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG fs/udf/super.c:1546:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:534:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:561:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG fs/udf/super.c:570:udf_vrs: ISO9660 Volume Descriptor Set Terminator found
UDF-fs DEBUG fs/udf/super.c:877:udf_load_pvoldesc: recording time 1082448386/0, 2004/04/20 09:06 (103c)
UDF-fs DEBUG fs/udf/super.c:888:udf_load_pvoldesc: volIdent[] = 'CDROM'
UDF-fs DEBUG fs/udf/super.c:895:udf_load_pvoldesc: volSetIdent[] = '040420_0906'
UDF-fs DEBUG fs/udf/super.c:1087:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
UDF-fs DEBUG fs/udf/super.c:1097:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:925:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG fs/udf/super.c:1007:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 257, block length 2172880
UDF-fs DEBUG fs/udf/super.c:1340:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG fs/udf/super.c:1573:udf_fill_super: Lastblock=0
UDF-fs DEBUG fs/udf/super.c:849:udf_find_fileset: Fileset at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:911:udf_load_fileset: Rootdir at block=2, partition=0
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'CDROM', timestamp 2004/04/20 10:06 (1078)

But I'm unable to stat/read/whatever the files:

root@dreamland:~# ls /cdrom
/bin/ls: /cdrom/Bakuretsu Tenshi - 01.avi: No such file or directory
/bin/ls: /cdrom/Bakuretsu Tenshi - 02.avi: No such file or directory
[etc]

I can mount the disk and read it using ISO9660 instead of UDF (filenames
are 8+3, no Joliet it seems), and I can read it under WinXP. It
shouldn't be damaged.

Any clue?

Luca
-- 
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein
