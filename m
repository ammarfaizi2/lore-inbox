Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbRLRUcd>; Tue, 18 Dec 2001 15:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285094AbRLRUcS>; Tue, 18 Dec 2001 15:32:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12178 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285093AbRLRUcE>;
	Tue, 18 Dec 2001 15:32:04 -0500
Date: Tue, 18 Dec 2001 12:31:30 -0800 (PST)
Message-Id: <20011218.123130.58437921.davem@redhat.com>
To: davej@suse.de
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: More fun with fsx.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112171523460.28670-100000@Appserv.suse.de>
In-Reply-To: <15389.49646.612985.293315@charged.uio.no>
	<Pine.LNX.4.33.0112171523460.28670-100000@Appserv.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@suse.de>
   Date: Mon, 17 Dec 2001 15:30:32 +0100 (CET)

   On Mon, 17 Dec 2001, Trond Myklebust wrote:

   > However, 2 races + 4 bugs observed is already pretty much a record for
   > a single program. Kudos to the NeXT developers...
   
   Indeed. It's a really neat tool, we could use more like it.

It also is good at finding cache flushing bugs on platforms
where that is an issue :-)

BTW, here is a portability fix for fsx-linux.c :-)

--- fsx-linux.c.~1~	Mon Dec 17 16:24:11 2001
+++ fsx-linux.c	Mon Dec 17 16:28:19 2001
@@ -67,7 +67,7 @@
 #define OP_SKIPPED	7
 
 #ifndef PAGE_SIZE
-#define PAGE_SIZE       4096
+#define PAGE_SIZE       getpagesize()
 #endif
 #define PAGE_MASK       (PAGE_SIZE - 1)
 
