Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVILVCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVILVCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVILVCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:02:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932236AbVILVCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:02:32 -0400
Date: Mon, 12 Sep 2005 14:02:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] LSM update, add securityfs
Message-ID: <20050912210230.GF7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an LSM update for 2.6.14.  It's been in -mm for ages.
This adds securityfs, and converts seclvl over.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/

thanks,
-chris
--

 include/linux/security.h |    5 
 security/Kconfig         |    1 
 security/Makefile        |    2 
 security/inode.c         |  347 +++++++++++++++++++++++++++++++++++++++++++++++
 security/seclvl.c        |  228 +++++++++---------------------
 5 files changed, 424 insertions(+), 159 deletions(-)

Adrian Bunk:
  SECURITY must depend on SYSFS

Greg KH:
  add securityfs for all LSMs to use

serue@us.ibm.com:
  seclvl securityfs

