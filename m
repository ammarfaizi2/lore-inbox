Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWECMzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWECMzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWECMzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:55:19 -0400
Received: from mail.axxeo.de ([82.100.226.146]:54428 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S965184AbWECMzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:55:17 -0400
From: Ingo Oeser <kernel-bugs@axxeo.de>
Organization: Axxeo GmbH
To: ext3-users@redhat.com
Subject: We hit ext3_warning (inode->i_sb, "ext3_block_to_path", "block < 0");
Date: Wed, 3 May 2006 14:54:56 +0200
User-Agent: KMail/1.7.2
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031454.56891.kernel-bugs@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ext3-users,

we hit this condition in fs/ext3/inode.c:ext3_block_to_path()

 if (i_block < 0) {
                ext3_warning (inode->i_sb, "ext3_block_to_path", "block < 0");

occasionally on two identical PATA-IDE disks copied over per filesystem-rsync.


What is the impact of this condition?

- Kernel was 2.6.13.4, CONFIG_LBD is not set but CONFIG_HIGHMEM4G=y
  (I can provide further details, if required)
- S.M.A.R.T meant everything is ok on both disks.
- Machine has been rebooted and fscked (180 days without reboot).
- Result of this fsck is not known.

The condition didn't happen after this anymore.


Regards

Ingo Oeser
-- 
Ingo Oeser
axxeo GmbH
Tiestestr. 16, 30171 Hannover
Tel. +49-511-4753706
Fax. +49-511-4753716

mailto:support@axxeo.de
