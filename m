Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267348AbUGNKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUGNKjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUGNKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:39:42 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:40169 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267348AbUGNKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:39:26 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
	<m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org>
	<40ED049B.2020406@yahoo.com.au>
	<Pine.LNX.4.58.0407081126360.3104@telia.com>
	<20040714052010.GE3411@holomorphy.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2004 12:39:18 +0200
In-Reply-To: <20040714052010.GE3411@holomorphy.com>
Message-ID: <m2u0wayisp.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Thu, Jul 08, 2004 at 11:30:45AM +0200, Peter Osterlund wrote:
> > swappiness is set to 60.
> > However, I realized that I had set /proc/sys/vm/laptop_mode to 1. If I set
> > it to 0, 2.6.7-bk10 starts to work.
> 
> Probably not what will get merged, but does the following brutal hack
> do anything for you?

Doesn't help. I added some printk's to your patch and got this:

try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:4 unstable:0
try_to_free_pages: lap:1 totscan:256 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:512 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:120 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:248 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:504 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:256 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:511 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:256 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:508 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:959 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:952 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:960 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:956 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:256 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:488 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:1715 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:628 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:1852 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:1856 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:1848 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:73 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:137 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:128 dirty:0 unstable:0
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:64 dirty:0 unstable:0
try_to_free_pages: oom
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:265 dirty:0 unstable:0
try_to_free_pages: oom
try_to_free_pages: lap:1 totscan:256 dirty:0 unstable:0
try_to_free_pages: lap:1 totscan:576 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: lap:1 totscan:182 dirty:0 unstable:0
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom
Out of Memory: Killed process 2603 (memalloc2).
try_to_free_pages: ---
try_to_free_pages: setting may_writepage=1
try_to_free_pages: oom

---

 linux-petero/mm/vmscan.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~laptop-swap-fix mm/vmscan.c
--- linux/mm/vmscan.c~laptop-swap-fix	2004-07-14 10:30:02.000000000 +0200
+++ linux-petero/mm/vmscan.c	2004-07-14 12:22:53.000000000 +0200
@@ -897,12 +897,13 @@ int try_to_free_pages(struct zone **zone
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	int i;
+	int first = 1;
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 
 	inc_page_state(allocstall);
-
+retry:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->temp_priority = DEF_PRIORITY;
 
@@ -932,6 +933,14 @@ int try_to_free_pages(struct zone **zone
 		 * writeout.  So in laptop mode, write out the whole world.
 		 */
 		if (total_scanned > SWAP_CLUSTER_MAX + SWAP_CLUSTER_MAX/2) {
+			int dirty = read_page_state(nr_dirty);
+			int unstable = read_page_state(nr_unstable);
+			if (first) {
+				printk("try_to_free_pages: ---\n");
+				first = 0;
+			}
+			printk("try_to_free_pages: lap:%d totscan:%d dirty:%d unstable:%d\n",
+			       laptop_mode, total_scanned, dirty, unstable);
 			wakeup_bdflush(laptop_mode ? 0 : total_scanned);
 			sc.may_writepage = 1;
 		}
@@ -940,8 +949,24 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory();
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+		if (!laptop_mode || sc.may_writepage) {
+			if (first) {
+				printk("try_to_free_pages: ---\n");
+				first = 0;
+			}
+			printk("try_to_free_pages: oom\n");
+			out_of_memory();
+		} else {
+			if (first) {
+				printk("try_to_free_pages: ---\n");
+				first = 0;
+			}
+			printk("try_to_free_pages: setting may_writepage=1\n");
+			sc.may_writepage = 1;
+			goto retry;
+		}
+	}
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
