Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTDXRiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTDXRiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:38:52 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:35076 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263418AbTDXRiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:38:51 -0400
Message-ID: <3EA823DC.FD84455@SteelEye.com>
Date: Thu, 24 Apr 2003 13:50:20 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.68-bk latest] allow modular JBD
Content-Type: multipart/mixed;
 boundary="------------1AC8094B882AB5C95A1334A8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1AC8094B882AB5C95A1334A8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Currently, when I build ext3 as a module, jbd gets built into the kernel
proper. This trivial patch allows jbd to be built as a module when ext3
is also modular. I believe this is the intention, as this is how it
works in 2.4. I've built and tested with modular jbd and ext3 on 2.5.68.
Please apply.

Thanks,
Paul
--------------1AC8094B882AB5C95A1334A8
Content-Type: text/plain; charset=us-ascii;
 name="jbd_modular_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jbd_modular_patch.diff"

--- linux-2.5/fs/Kconfig.PRISTINE	Thu Apr 24 13:23:49 2003
+++ linux-2.5/fs/Kconfig	Thu Apr 24 13:23:57 2003
@@ -135,7 +135,7 @@
 # CONFIG_JBD could be its own option (even modular), but until there are
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-	bool
+	tristate
 	default EXT3_FS
 	help
 	  This is a generic journaling layer for block devices.  It is

--------------1AC8094B882AB5C95A1334A8--

