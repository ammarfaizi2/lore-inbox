Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVDXPHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVDXPHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVDXPHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:07:51 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:4280 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262334AbVDXPHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:07:40 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3 fails to read partition table
Date: Sun, 24 Apr 2005 14:37:54 GMT
Message-ID: <055UDZ711@server5.heliogroup.fr>
X-Mailer: Pliant 93
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------GV0HBJ81UEEPQ1GVX5QMRUXT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------GV0HBJ81UEEPQ1GVX5QMRUXT
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

2.6.11 and 2.6.11.7 work fine.
2.6.12-rc1 2.6.12-rc2 and 2.6.12-rc3 fail to read partiton table on my laptop,
also 2.6.12-rc3 works fine on another box also running FullPliant.

The meaningfull part of the boot sequence log is:

With 2.6.11.x:
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1

With 2.6.12-rcx:
hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda:
so with 2.6.12-rcx, the boot process ends with an unpleasant:
VFS: Cannot open root device "301" or unknown-bloc(3,1)

The partition table has been created by Pliant partition tool:
http://fullpliant.org/pliant/linux/storage/partition.pli
function 'partition_create' at line 52.
Since most of you are probably not awared of Pliant programming language,
neither FullPliant operating system,
I've attached 'dd if=/dev/hda of=/tmp/partition.bin bs=512 count=1'
--------GV0HBJ81UEEPQ1GVX5QMRUXT
Content-Type: application/octet-stream; name="partition.bin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="partition.bin"

+ushAbUBTElMTxYGEK9rQgAAAAAAAAAAsxKwPQAAgEAnw44AuMAHjtC8AAj7UlMGVvyO2DHt
YLgAErM2zRBhsA3oZwGwCuhiAbBM6F0BYB4HgPr+dQKI8rsAAop2HonQgOSAMOB4CjwQcwb2
RhxAdS6I8maLdhhmCfZ0I1K0CLKAU80TW3JVD7bKun8AQmYxwEDocABmO7e4AXQD4u9aU4p2
H74gAOhKALSZZoF//ExJTE91J15ogAgHMdvoNAB1+74GAIn3uQoA86Z1DbACrnUIBlWwSejS
AMu0mrAg6MoA6LcA/k4AdAe86Adh6V7/9Ov9Zq1mCcB0CmYDRhDoBACAxwLDYFVVZlAGU2oB
ahCJ5lP2xmB0WPbGIHQUu6pVtEHNE3ILgftVqnUF9sEBdUpSBrQIzRMHcllRwOkGhumJz1nB
6giSQIPhP/fhk4tECItUCjnaczn38zn4dzPA5AaG4JL28QjiidFBWojG6wZmUFlYiOa4AQLr
ArRCW70FAGDNE3MQTXQKMcDNE2FN6/C0QOlG/41kEGHDwcAE6AMAwcAEJA8nBPAUQGC7BwC0
Ds0QYcMAAACzErA9z8mAAAAAAAAAAEAAAABAfPwGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVao=
--------GV0HBJ81UEEPQ1GVX5QMRUXT--
