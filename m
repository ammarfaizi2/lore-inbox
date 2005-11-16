Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVKPJEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVKPJEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVKPJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:04:22 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:55977 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030247AbVKPJEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:04:21 -0500
Message-ID: <437AF612.6050402@namesys.com>
Date: Wed, 16 Nov 2005 01:04:18 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       vs <vs@thebsh.namesys.com>
Subject: [Fwd: [PATCH] clear_page_dirty_for_io.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020102080402060209070201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102080402060209070201
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------020102080402060209070201
Content-Type: message/rfc822;
 name="[PATCH] clear_page_dirty_for_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] clear_page_dirty_for_io.patch"

Return-Path: <vs@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24712 invoked from network); 15 Nov 2005 17:02:31 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO ?192.168.1.10?) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:02:31 -0000
Message-ID: <437A1493.5060000@namesys.com>
Date: Tue, 15 Nov 2005 20:02:11 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Subject: [PATCH] clear_page_dirty_for_io.patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090601070101070405030001"

This is a multi-part message in MIME format.
--------------090601070101070405030001
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is a request to make clear_page_dirty_for_io() EXPORT_SYMBOL. 2.6.14 has it
exported. So, there is nothing wrong in asking to EXPORT_SYMBOL it back.

--------------090601070101070405030001
Content-Type: text/plain;
 name="export-clear_page_dirty_for_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export-clear_page_dirty_for_io.patch"


From: Vladimir V. Saveliev <vs@namesys.com>

This patch makes clear_page_dirty_for_io to be EXTERN_SYMBOL.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 mm/page-writeback.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN mm/page-writeback.c~export-clear_page_dirty_for_io mm/page-writeback.c
--- linux-2.6.14-mm2/mm/page-writeback.c~export-clear_page_dirty_for_io	2005-11-14 18:33:38.000000000 +0300
+++ linux-2.6.14-mm2-vs/mm/page-writeback.c	2005-11-14 18:34:17.000000000 +0300
@@ -751,6 +751,8 @@ int clear_page_dirty_for_io(struct page 
 	return TestClearPageDirty(page);
 }
 
+EXPORT_SYMBOL(clear_page_dirty_for_io);
+
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);

_

--------------090601070101070405030001--



--------------020102080402060209070201--
