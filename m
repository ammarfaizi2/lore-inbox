Return-Path: <linux-kernel-owner+willy=40w.ods.org-S319562AbUKBEt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S319562AbUKBEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378105AbUKAWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:42:56 -0500
Received: from [168.159.2.31] ([168.159.2.31]:4321 "EHLO mailhub.lss.emc.com")
	by vger.kernel.org with ESMTP id S315555AbUKAUnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:43:11 -0500
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F550846C0C2@srgraham.eng.emc.com>
From: "usvyatsky, ilya" <usvyatsky_ilya@emc.com>
To: linux-kernel@vger.kernel.org
Subject: General dcache question
Date: Mon, 1 Nov 2004 15:42:58 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.11.1.2
X-PerlMx-Spam: Gauge=, SPAM=7%, Report='EMC_FROM_0 -0, __TLG_EMC_ENVFROM_0 0, __IMS_MSGID 0, __HAS_MSGID 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __MIME_VERSION 0, __ANY_IMS_MUA 0, __IMS_MUA 0, __HAS_X_MAILER 0, __CT_TEXT_PLAIN 0, __CT 0, __MIME_TEXT_ONLY 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
Sorry if this question does not really belong to this list, but it seems to
me that someone here can simply know the answer.
I am looking at Linux dcache mechanism trying to retreive a name (actually,
full path) of an active inode.
It seems that each active inode has a linked list of dentry's (i_dentry)
that holds a (partial) list of its names (links in fact),
and each dentry has d_name and d_parent.
Moshe Bar in his "Linux File Systems" book states that for every active
inode i_dentry would always contain at least one active
dentry. Moreover, such d_entry would have a valid d_parent field pointing at
active dcache entry containing a name of the parent directory. He also says
that only leaves with d_count equal to 0 are on the dcache LRU list.
Now, I wonder if the following assumption is true:
	For each active inode, there always be enough dcache entries (linked
through d_parent pointer) to restore the full path of the 	inode from
the root.
I also would appreciate it very much if someone familiar with 2.6 kernel
would confirm that this assumption still holds there.
Thanks a lot,
Ilya Usvyatsky.

