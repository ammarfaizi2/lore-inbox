Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULHP7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULHP7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbULHP7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:59:38 -0500
Received: from main.gmane.org ([80.91.229.2]:19923 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261239AbULHP7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:59:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Why is "SAMSUNG CD-ROM SC-148F" blacklisted?
Date: Wed, 08 Dec 2004 20:58:36 +0500
Message-ID: <cp78ct$d65$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "SAMSUNG CD-ROM SC-148F" drive is listed in drive_blacklist in
ide-dma.c. However, this drive worked well with DMA enabled with earlier
kernel versions (<=2.6.8.1) where the "via82cxxx" driver did not look at
this blacklist. So the question: what was the reason for blacklisting this
(apparently working) drive? Is it still valid?

Details on my CD-ROM drive are pasted below.

patrakov@debian:~$ cdrecord -inq dev=/dev/hdb
Cdrecord-Clone 2.01a34 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg
Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of
cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to
<cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this
version.

scsidev: '/dev/hdb'
devname: '/dev/hdb'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
cdrecord: Warning: controller returns wrong size for CD capabilities page.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'SAMSUNG '
Identifikation : 'CD-ROM SC-148F  '
Revision       : 'PS05'
Device seems to be: Generic mmc CD-ROM.

-- 
Alexander E. Patrakov

