Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVLMIYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVLMIYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVLMIYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:24:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:31107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932544AbVLMIYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:42 -0500
Date: Tue, 13 Dec 2005 00:23:56 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       mikem@beardog.cca.cpqcorp.net, axboe@suse.de
Subject: [patch 24/26] - stable review cciss: bug fix for hpacucli
Message-ID: <20051213082356.GY5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cciss-bug-fix-for-hpacucli.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Mike Miller <mikem@beardog.cca.cpqcorp.net>

This patch fixes a bug that breaks hpacucli, a command line interface
for the HP Array Config Utility. Without this fix the utility will
not detect any controllers in the system. I thought I had already fixed
this, but I guess not.

Thanks to all who reported the issue. Please consider this this inclusion.

Signed-off-by: Mike Miller <mikem@beardog.cca.cpqcorp.net>
Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/cciss_ioctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.3.orig/include/linux/cciss_ioctl.h
+++ linux-2.6.14.3/include/linux/cciss_ioctl.h
@@ -10,8 +10,8 @@
 typedef struct _cciss_pci_info_struct
 {
 	unsigned char 	bus;
-	unsigned short	domain;
 	unsigned char 	dev_fn;
+	unsigned short	domain;
 	__u32 		board_id;
 } cciss_pci_info_struct; 
 

--
