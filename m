Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUCQUJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUCQUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:09:57 -0500
Received: from ns.suse.de ([195.135.220.2]:46812 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262041AbUCQUJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:09:14 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <20040316180043.441e8150.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
	 <1079485055.4181.1115.camel@watt.suse.com>
	 <1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	 <20040316180043.441e8150.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079554288.4183.1938.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 15:11:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ data not getting flushed ]

Ummm, this might help:

-chris

--- l/mm/filemap.c.1	2004-03-17 15:08:37.581083800 -0500
+++ l/mm/filemap.c	2004-03-17 15:08:47.105635848 -0500
@@ -180,7 +180,7 @@ static int wait_on_page_writeback_range(
 	int ret = 0;
 	pgoff_t index;
 
-	if (end > start)
+	if (end < start)
 		return 0;
 
 	pagevec_init(&pvec, 0);


