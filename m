Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTGPShz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271074AbTGPSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:36:07 -0400
Received: from ns.suse.de ([213.95.15.193]:27406 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271062AbTGPSfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:35:43 -0400
Date: Wed, 16 Jul 2003 20:49:22 +0200
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.22, missing includes for quota
Message-ID: <20030716184922.GA23284@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ioctl32.c uses some defines from linux/quotacompat.h, but that one is not
included.

Can you send that in for inclusion?

diff -purN linux-2.4.22-pre4/arch/ppc64/kernel/sys_ppc32.c linux-2.4.22-pre4.kaputterframebuffer/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.4.22-pre4/arch/ppc64/kernel/sys_ppc32.c	2003-07-10 12:48:30.000000000 +0200
+++ linux-2.4.22-pre4.kaputterframebuffer/arch/ppc64/kernel/sys_ppc32.c	2003-07-10 14:47:32.000000000 +0200
@@ -39,6 +39,7 @@
 #include <linux/smb_mount.h>
 #include <linux/ncp_fs.h>
 #include <linux/quota.h>
+#include <linux/quotacompat.h>
 #include <linux/module.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>

-- 
USB is for mice, FireWire is for men!
