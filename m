Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUBAWZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBAWZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:25:44 -0500
Received: from [62.38.238.134] ([62.38.238.134]:35820 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S265438AbUBAWZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:25:41 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Q: large files in iso9660 ?
Date: Mon, 2 Feb 2004 00:24:31 +0200
User-Agent: KMail/1.6
Cc: viro@math.psu.edu
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402020024.31785.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I've tried to create a disk (DVD) which contains a single 3.8GB file. The 
creation (mkisofs) worked and the disk's TOC reads 3.8GB. However, the 
filesystem reads as if one ~9MB file only exists. 
I guess large files in isofs may be out of spec. 

Q: What's the file size limit in iso9660?
Q: Is there any chance the negative number (although out of spec) may be 
correctly interpreted (mount option) ?

Thanks.

FYI:
isoinfo -d -i /dev/cdrom
CD-ROM is in ISO 9660 format
System id: LINUX
Volume id: CDROM
Volume set id:
Publisher id:
Data preparer id:
Application id: MKISOFS ISO 9660/HFS FILESYSTEM BUILDER & CDRECORD CD-R/DVD 
CREATOR (C) 1993 E.YOUNGDALE (C) 1997 J.PEARSON/J.SCHILLING
Copyright File id:
Abstract File id:
Bibliographic File id:
Volume set size is: 1
Volume set seqence number is: 1
Logical block size is: 2048
Volume size is: 1987287
Joliet with UCS level 3 found
Rock Ridge signatures version 1 found

isoinfo -l -i /dev/cdrom

Directory listing of /
d---------   0    0    0            2048 Jan 31 2004 [     28]  .
d---------   0    0    0            2048 Jan 31 2004 [     28]  ..
----------   0    0    0      -225376141 Jan 31 2004 [     31]  WIN_C.TGZ;1
