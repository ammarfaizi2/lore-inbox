Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRAMSbB>; Sat, 13 Jan 2001 13:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131110AbRAMSay>; Sat, 13 Jan 2001 13:30:54 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131165AbRAMSZ1>;
	Sat, 13 Jan 2001 13:25:27 -0500
Date: Sat, 13 Jan 2001 22:49:56 -0800
From: hugang <linuxhappy@etang.com>
To: linux-kernel@vger.kernel.org
Subject: patch:reiserfs 3.6.25 + LVM
Message-Id: <20010113224956.54b6f5e1.linuxhappy@etang.com>
X-Mailer: Sylpheed version 0.4.52 (GTK+ 1.2.8; Linux 2.4.1-pre2; i686)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- reiserfs_fs.h       Sat Jan 13 22:46:42 2001
+++ reiserfs_fs.h.old   Sat Jan 13 22:17:45 2001
@@ -1420,7 +1420,7 @@
 #define op_is_left_mergeable(key,bsize)              item_ops[le_key_k_type (le_key_version (key), key)]->is_left_mergeable (key, bsize)
 #define op_print_item(ih,item)                       item_ops[le_ih_k_type (ih)]->print_item (ih, item)
 #define op_check_item(ih,item)                       item_ops[le_ih_k_type (ih)]->check_item (ih, item)
-#define op_create_vi(vn,vi,is_affected,insert_size)  item_ops[le_ih_k_type(vi->vi_ih)]->create_vi > 0 ? item_ops[le_ih_k_type (vi->vi_ih)]->create_vi(vn,vi,is_affected,insert_size) : 0
+#define op_create_vi(vn,vi,is_affected,insert_size)  item_ops[le_ih_k_type (vi->vi_ih)]->create_vi (vn,vi,is_affected,insert_size)
 #define op_check_left(vi,free,start_skip,end_skip)   item_ops[(vi)->vi_index]->check_left (vi, free, start_skip, end_skip)
 #define op_check_right(vi,free)                      item_ops[(vi)->vi_index]->check_right (vi, free)
 #define op_part_size(vi,from,to)                     item_ops[(vi)->vi_index]->part_size (vi, from, to)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
