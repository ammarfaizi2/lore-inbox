Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWJKVFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWJKVFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWJKVE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:04:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:19870 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161390AbWJKVEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:52 -0400
Date: Wed, 11 Oct 2006 14:04:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/67] zd1211rw: ZD1211B ASIC/FWT, not jointly decoder
Message-ID: <20061011210412.GL16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="zd1211rw-zd1211b-asic-fwt-not-jointly-decoder.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Drake <dsd@gentoo.org>

The vendor driver chooses this value based on an ifndef ASIC,
and ASIC is never defined.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/zd1211rw/zd_chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/net/wireless/zd1211rw/zd_chip.c
+++ linux-2.6.18/drivers/net/wireless/zd1211rw/zd_chip.c
@@ -717,7 +717,7 @@ static int zd1211b_hw_reset_phy(struct z
 		{ CR21,  0x0e }, { CR22,  0x23 }, { CR23,  0x90 },
 		{ CR24,  0x14 }, { CR25,  0x40 }, { CR26,  0x10 },
 		{ CR27,  0x10 }, { CR28,  0x7f }, { CR29,  0x80 },
-		{ CR30,  0x49 }, /* jointly decoder, no ASIC */
+		{ CR30,  0x4b }, /* ASIC/FWT, no jointly decoder */
 		{ CR31,  0x60 }, { CR32,  0x43 }, { CR33,  0x08 },
 		{ CR34,  0x06 }, { CR35,  0x0a }, { CR36,  0x00 },
 		{ CR37,  0x00 }, { CR38,  0x38 }, { CR39,  0x0c },

--
