Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVACVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVACVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVACVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:00:36 -0500
Received: from av9-1-sn4.m-sp.skanova.net ([81.228.10.108]:45253 "EHLO
	av9-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261826AbVACU75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:59:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: Small documentation update
References: <20050103011113.6f6c8f44.akpm@osdl.org> <m3acrqutwe.fsf@telia.com>
	<m3652eutqw.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2005 21:47:23 +0100
In-Reply-To: <m3652eutqw.fsf_-_@telia.com>
Message-ID: <m31xd2utno.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mention that a new DVD+RW disc has to be formatted before first use.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/Documentation/cdrom/packet-writing.txt |    3 +++
 1 files changed, 3 insertions(+)

diff -puN Documentation/cdrom/packet-writing.txt~packet-doc-fix Documentation/cdrom/packet-writing.txt
--- linux/Documentation/cdrom/packet-writing.txt~packet-doc-fix	2005-01-02 22:27:34.795395208 +0100
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2005-01-02 22:27:34.798394752 +0100
@@ -43,6 +43,8 @@ shall implement "true random writes with
 that it should be possible to put any filesystem with a block size >=
 2KB on such a disc. For example, it should be possible to do:
 
+	# dvd+rw-format /dev/hdc   (only needed if the disc has never
+	                            been formatted)
 	# mkudffs /dev/hdc
 	# mount /dev/hdc /cdrom -t udf -o rw,noatime
 
@@ -54,6 +56,7 @@ writes are not 32KB aligned.
 Both problems can be solved by using the pktcdvd driver, which always
 generates aligned writes.
 
+	# dvd+rw-format /dev/hdc
 	# pktsetup dev_name /dev/hdc
 	# mkudffs /dev/pktcdvd/dev_name
 	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
