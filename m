Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUI3RwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUI3RwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUI3Rvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:51:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269374AbUI3Rvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:51:31 -0400
Date: Thu, 30 Sep 2004 13:51:05 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: PATCH: scsi docs
Message-ID: <20040930175105.GA30529@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People have had a long time to change and be aware of the correct return.
Some drivers now generate the correct return too.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/Documentation/scsi/scsi_mid_low_api.txt linux-2.6.9rc3/Documentation/scsi/scsi_mid_low_api.txt
--- linux.vanilla-2.6.9rc3/Documentation/scsi/scsi_mid_low_api.txt	2004-09-30 16:13:07.221587568 +0100
+++ linux-2.6.9rc3/Documentation/scsi/scsi_mid_low_api.txt	2004-09-30 16:32:22.300988808 +0100
@@ -1091,10 +1091,6 @@
  *      mid level does not recognize it, then the LLD that controls
  *      the device receives the ioctl. According to recent Unix standards
  *      unsupported ioctl() 'cmd' numbers should return -ENOTTY.
- *      However the mid level returns -EINVAL for unrecognized 'cmd'
- *      numbers when this function is not supplied by the driver.
- *      Unfortunately some applications expect -EINVAL and react badly
- *      when -ENOTTY is returned; stick with -EINVAL.
  *
  *      Optionally defined in: LLD
  **/
