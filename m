Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUAOAfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbUAOAfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:35:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44174 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264547AbUAOAfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:35:06 -0500
Message-ID: <4005E02D.703@pobox.com>
Date: Wed, 14 Jan 2004 19:34:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [SATA] libata update posted, and news
Content-Type: multipart/mixed;
 boundary="------------040606030709000208070300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040606030709000208070300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Updates to the Silicon Image and ServerWorks drivers.

News:
* will freeze current codebase as libata 1.0, without queueing support. 
  libata 2.x development has already begun, and will support queueing, 
sata2, and will build upon the existing codebase.
* ServerWorks seems stable, will remove 'beta' label soon

Notes:
* Silicon Image support is still considered to be unstable. 
drivers/ide's siimage.c is preferred.
* Silicon Image users with Seagate SATA, particularly if you know if you 
have the "mod15write" bug, should make sure that the driver is properly 
applying the errata fix.

Patch for 2.4.x:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-pre4-libata1.patch.bz2

Patch for 2.6.x:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.1-bk2-libata1.patch.bz2

BK repositories:
bk://gkernel.bkbits.net/libata-2.[45]

Changelog versus 2.6.x mainline attached.



--------------040606030709000208070300
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

ChangeSet@1.1513, 2004-01-14 18:44:53-05:00, benh@kernel.crashing.org
  [libata sata_svw] cleanup, better probing
  
  * use fewer magic numbers
  * probe all 4 ports, using standard SATA SCRs
  * limit udma mask to 0x3f
  * clean up PPC-specific procfs stuff

ChangeSet@1.1512, 2004-01-14 18:34:48-05:00, arubin@atl.lmco.com
  [libata sata_sil] add pci id for Silicon Image 3512

ChangeSet@1.1511, 2004-01-14 18:19:36-05:00, normalperson@yhbt.net
  [libata sata_sil] cleaner, better version of errata workarounds
  
  No longer unfairly punishes non-errata Seagate and Maxtor drives.

ChangeSet@1.1474.72.3, 2004-01-06 04:26:01-05:00, marchand@kde.org
  [libata sata_sil] add support for adaptec 1210sa, 4-port sii 3114

ChangeSet@1.1474.72.2, 2004-01-06 04:22:09-05:00, jgarzik@redhat.com
  [libata sata_svr] fix DRV_NAME to reflect actual driver filename

ChangeSet@1.1474.61.1, 2003-12-30 19:46:09-05:00, jgarzik@redhat.com
  [libata sata_sil] unmask interrupts during initialization
  
  Prudent in general, and needed for Adaptec BIOSes.


--------------040606030709000208070300--

