Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269722AbUICSqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269722AbUICSqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269741AbUICSm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:42:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11140 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S269738AbUICSlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:41:32 -0400
Date: Fri, 3 Sep 2004 11:40:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.9-rc1 0/3] zlib_inflate and ppc32 changes
Message-ID: <20040903184012.GC6290@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  This series of patches first changes zlib_inflate/ to be more
easily picked at by moving some non-core functions into their own file.
Next, this switches zlib_inflate_trees_fixed(...) from using a static
table, to generating that table.  This can save us up to 4kB from the
vmlinux (ppc32) and when used in the boot/ code, up to 8kB.  Finally, we
switch arch/ppc/boot/ from using it's own version of zlib to using
lib/zlib_inflate.  All of this should also lead the way for
lib/inflate.c going away.

-- 
Tom Rini
http://gate.crashing.org/~trini/
