Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTENNE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTENNE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:04:58 -0400
Received: from angband.namesys.com ([212.16.7.85]:46466 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262226AbTENNE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:04:56 -0400
Date: Wed, 14 May 2003 17:17:43 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] export balance_dirty
Message-ID: <20030514131743.GB1875@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    We seem to need balance_dirty to be exported now with latest
    reiserfs patches (so that reiserfs can be built as module).
    Please apply (against latest 2.4 bk tree).

    Thank you.

Bye,
    Oleg

===== fs/buffer.c 1.82 vs edited =====
--- 1.82/fs/buffer.c	Mon Dec 16 09:22:07 2002
+++ edited/fs/buffer.c	Wed May 14 16:51:00 2003
@@ -1026,6 +1026,7 @@
 		write_some_buffers(NODEV);
 	}
 }
+EXPORT_SYMBOL(balance_dirty);
 
 inline void __mark_dirty(struct buffer_head *bh)
 {
