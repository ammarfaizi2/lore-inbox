Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDDTPR>; Wed, 4 Apr 2001 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRDDTPI>; Wed, 4 Apr 2001 15:15:08 -0400
Received: from james.kalifornia.com ([208.179.59.2]:38515 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131949AbRDDTOu>; Wed, 4 Apr 2001 15:14:50 -0400
Message-ID: <3ACB727E.D8B7C824@blue-labs.org>
Date: Wed, 04 Apr 2001 12:14:06 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Another report of mozilla in D state, related to the 'uninterruptible 
 sleep' thread
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second time around, I didn't evoke any interest the first time.

I reported it back on Mar/27.  It is still an almost daily problem
requiring a reboot.  Mozilla gets stuck in down_write_failed.  This time
I'm sure it's not reiser's fault.

# uname -r
2.4.3-pre8

mozilla-bin  D C781849C     0 21055      1        (NOTLB)         20611
 Call Trace: [<ff000000>] [<ff000000>] [<ff000000>]
[leaf_copy_items+121/252]
   [leaf_paste_in_buffer+239/672] [leaf_cut_from_buffer+486/984]
   [leaf_cut_from_buffer+863/984] [balance_leaf+8645/9544]
   [balance_leaf+9225/9544] [leaf_item_bottle+916/1260]
   [balance_leaf+9505/9544] [balance_leaf+9225/9544]
   [leaf_item_bottle+916/1260] [balance_leaf+9505/9544] [<f0000000>]
   [bin_search_in_dir_item+58/196] [leaf_copy_items+121/252]
   [leaf_paste_in_buffer+239/672] [<d086f044>]
   [flush_commit_list+66/908] [flush_journal_list+531/944]
   [free_list_bitmaps+30/60] [reiserfs_unlink+167/460]
   [posix_lock_file+526/1232] [empty_bad_page+3213/4096]
   [empty_bad_page+2717/4096] [fib_flag_trans+35/60]
   [empty_bad_pte_table+3363/4096]

If someone is actually interested, it'd be neat to get this fixed.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



