Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSLBWXb>; Mon, 2 Dec 2002 17:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLBWXb>; Mon, 2 Dec 2002 17:23:31 -0500
Received: from [209.184.141.189] ([209.184.141.189]:59345 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265095AbSLBWXZ>;
	Mon, 2 Dec 2002 17:23:25 -0500
Subject: 2.4.20 + XFS patches + rmap15a + Ingo's 2.4.20-rc3 O(1) sched
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038868227.12048.23.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 16:30:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the output I get when running "make bzImage". 

There was one reject from sched.h when patching Ingo's O(1) 2.4.20-rc3
patch. It is at the bottom.


<Errors>
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/dev/shm/linux-2.4.20/include  -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-fno-optimize-sibling-calls   -DKBUILD_BASENAME=main -c -o init/main.o
init/main.c
In file included from /dev/shm/linux-2.4.20/include/linux/mm.h:22,
                 from /dev/shm/linux-2.4.20/include/linux/slab.h:14,
                 from /dev/shm/linux-2.4.20/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/dev/shm/linux-2.4.20/include/linux/sched.h:358: parse error before
"list_t"
/dev/shm/linux-2.4.20/include/linux/sched.h:358: warning: no semicolon
at end of struct or union
/dev/shm/linux-2.4.20/include/linux/sched.h:378: parse error before ':'
token
/dev/shm/linux-2.4.20/include/linux/sched.h:409: parse error before ':'
token
/dev/shm/linux-2.4.20/include/linux/sched.h:416: parse error before ':'
token
/dev/shm/linux-2.4.20/include/linux/sched.h:460: parse error before '}'
token
/dev/shm/linux-2.4.20/include/linux/sched.h:568: field `task' has
incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `hash_pid':
/dev/shm/linux-2.4.20/include/linux/sched.h:584: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:584: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:586: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:587: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:587: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:589: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `unhash_pid':
/dev/shm/linux-2.4.20/include/linux/sched.h:594: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:595: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:595: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:596: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:596: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`find_task_by_pid':
/dev/shm/linux-2.4.20/include/linux/sched.h:603: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:603: dereferencing pointer
to incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/mm.h:22,
                 from /dev/shm/linux-2.4.20/include/linux/slab.h:14,
                 from /dev/shm/linux-2.4.20/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`signal_pending':
/dev/shm/linux-2.4.20/include/linux/sched.h:680: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`recalc_sigpending':
/dev/shm/linux-2.4.20/include/linux/sched.h:719: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:719: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:719: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `on_sig_stack':
/dev/shm/linux-2.4.20/include/linux/sched.h:726: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:726: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `sas_ss_flags':
/dev/shm/linux-2.4.20/include/linux/sched.h:731: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `suser':
/dev/shm/linux-2.4.20/include/linux/sched.h:756: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:757: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `fsuser':
/dev/shm/linux-2.4.20/include/linux/sched.h:765: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:766: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `capable':
/dev/shm/linux-2.4.20/include/linux/sched.h:781: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:786: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`unhash_process':
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:936: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:937: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `task_lock':
/dev/shm/linux-2.4.20/include/linux/sched.h:944: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `task_unlock':
/dev/shm/linux-2.4.20/include/linux/sched.h:949: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `d_path':
/dev/shm/linux-2.4.20/include/linux/sched.h:959: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:960: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:961: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h:962: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`set_need_resched':
/dev/shm/linux-2.4.20/include/linux/sched.h:973: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`clear_need_resched':
/dev/shm/linux-2.4.20/include/linux/sched.h:978: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`set_tsk_need_resched':
/dev/shm/linux-2.4.20/include/linux/sched.h:983: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function
`clear_tsk_need_resched':
/dev/shm/linux-2.4.20/include/linux/sched.h:988: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/linux/sched.h: In function `need_resched':
/dev/shm/linux-2.4.20/include/linux/sched.h:993: dereferencing pointer
to incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/slab.h:14,
                 from /dev/shm/linux-2.4.20/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/dev/shm/linux-2.4.20/include/linux/mm.h: In function `pf_gfp_mask':
/dev/shm/linux-2.4.20/include/linux/mm.h:704: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/linux/mm.h: In function `expand_stack':
/dev/shm/linux-2.4.20/include/linux/mm.h:724: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/linux/mm.h:725: dereferencing pointer to
incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/irq.h:69,
                 from /dev/shm/linux-2.4.20/include/asm/hardirq.h:6,
                 from
/dev/shm/linux-2.4.20/include/linux/interrupt.h:45,
                 from /dev/shm/linux-2.4.20/include/asm/smplock.h:6,
                 from /dev/shm/linux-2.4.20/include/linux/smp_lock.h:16,
                 from init/main.c:24:
/dev/shm/linux-2.4.20/include/asm/hw_irq.h: In function
`x86_do_profile':
/dev/shm/linux-2.4.20/include/asm/hw_irq.h:203: dereferencing pointer to
incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/smp_lock.h:16,
                 from init/main.c:24:
/dev/shm/linux-2.4.20/include/asm/smplock.h: In function `lock_kernel':
/dev/shm/linux-2.4.20/include/asm/smplock.h:47: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/smplock.h: In function
`unlock_kernel':
/dev/shm/linux-2.4.20/include/asm/smplock.h:62: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/smplock.h:65: dereferencing pointer to
incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/highmem.h:5,
                 from /dev/shm/linux-2.4.20/include/linux/vmalloc.h:8,
                 from /dev/shm/linux-2.4.20/include/asm/io.h:47,
                 from /dev/shm/linux-2.4.20/include/linux/blkdev.h:11,
                 from /dev/shm/linux-2.4.20/include/linux/blk.h:4,
                 from init/main.c:25:
/dev/shm/linux-2.4.20/include/asm/pgalloc.h: In function `get_pgd_fast':
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:78: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:79: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:81: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h: In function
`free_pgd_fast':
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:89: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:90: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:91: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h: In function
`pte_alloc_one_fast':
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:122: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:123: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:125: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h: In function
`pte_free_fast':
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:132: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:133: dereferencing pointer
to incomplete type
/dev/shm/linux-2.4.20/include/asm/pgalloc.h:134: dereferencing pointer
to incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/highmem.h:11,
                 from /dev/shm/linux-2.4.20/include/linux/vmalloc.h:8,
                 from /dev/shm/linux-2.4.20/include/asm/io.h:47,
                 from /dev/shm/linux-2.4.20/include/linux/blkdev.h:11,
                 from /dev/shm/linux-2.4.20/include/linux/blk.h:4,
                 from init/main.c:25:
/dev/shm/linux-2.4.20/include/asm/highmem.h: In function `kmap':
/dev/shm/linux-2.4.20/include/asm/highmem.h:64: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/highmem.h: In function `kunmap':
/dev/shm/linux-2.4.20/include/asm/highmem.h:73: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/highmem.h: In function `kmap_atomic':
/dev/shm/linux-2.4.20/include/asm/highmem.h:94: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/highmem.h: In function
`kunmap_atomic':
/dev/shm/linux-2.4.20/include/asm/highmem.h:110: dereferencing pointer
to incomplete type
In file included from init/main.c:32:
/dev/shm/linux-2.4.20/include/asm/bugs.h: In function `check_fpu':
/dev/shm/linux-2.4.20/include/asm/bugs.h:82: dereferencing pointer to
incomplete type
In file included from /dev/shm/linux-2.4.20/include/asm/kdb.h:79,
                 from /dev/shm/linux-2.4.20/include/linux/kdb.h:40,
                 from init/main.c:73:
/dev/shm/linux-2.4.20/include/asm/uaccess.h: In function `verify_area':
/dev/shm/linux-2.4.20/include/asm/uaccess.h:64: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/uaccess.h: In function
`__constant_copy_to_user':
/dev/shm/linux-2.4.20/include/asm/uaccess.h:550: dereferencing pointer
to incomplete type
In file included from /dev/shm/linux-2.4.20/include/asm/kdb.h:79,
                 from /dev/shm/linux-2.4.20/include/linux/kdb.h:40,
                 from init/main.c:73:
/dev/shm/linux-2.4.20/include/asm/uaccess.h: In function
`__constant_copy_from_user':
/dev/shm/linux-2.4.20/include/asm/uaccess.h:558: dereferencing pointer
to incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/kdb.h:40,
                 from init/main.c:73:
/dev/shm/linux-2.4.20/include/asm/kdb.h: In function
`__kdba_putarea_size':
/dev/shm/linux-2.4.20/include/asm/kdb.h:84: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/kdb.h:89: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/kdb.h:91: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/kdb.h: In function
`__kdba_getarea_size':
/dev/shm/linux-2.4.20/include/asm/kdb.h:98: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/kdb.h:102: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/asm/kdb.h:104: dereferencing pointer to
incomplete type
In file included from /dev/shm/linux-2.4.20/include/linux/kdb.h:277,
                 from init/main.c:73:
/dev/shm/linux-2.4.20/include/linux/usb.h: In function `wait_ms':
/dev/shm/linux-2.4.20/include/linux/usb.h:147: dereferencing pointer to
incomplete type
/dev/shm/linux-2.4.20/include/linux/usb.h:148: dereferencing pointer to
incomplete type
init/main.c: In function `start_kernel':
init/main.c:458: dereferencing pointer to incomplete type
make: *** [init/main.o] Error 1
</Errors>


<sched.h.rej>

***************
*** 302,336 ****
  
  	int lock_depth;		/* Lock depth */
  
- /*
-  * offset 32 begins here on 32-bit platforms. We keep
-  * all fields in a single cacheline that are needed for
-  * the goodness() loop in schedule().
-  */
- 	long counter;
- 	long nice;
- 	unsigned long policy;
- 	struct mm_struct *mm;
- 	int processor;
  	/*
- 	 * cpus_runnable is ~0 if the process is not running on any
- 	 * CPU. It's (1 << cpu) if it's running on a CPU. This mask
- 	 * is updated under the runqueue lock.
- 	 *
- 	 * To determine whether a process might run on a CPU, this
- 	 * mask is AND-ed with cpus_allowed.
  	 */
- 	unsigned long cpus_runnable, cpus_allowed;
- 	/*
- 	 * (only the 'next' pointer fits into the cacheline, but
- 	 * that's just fine.)
- 	 */
- 	struct list_head run_list;
- 	unsigned long sleep_time;
  
- 	struct task_struct *next_task, *prev_task;
- 	struct mm_struct *active_mm;
  	struct list_head local_pages;
  	unsigned int allocation_order, nr_local_pages;
  
  /* task state */
--- 350,375 ----
  
  	int lock_depth;		/* Lock depth */
  
  	/*
+ 	 * offset 32 begins here on 32-bit platforms.
  	 */
+ 	unsigned int cpu;
+ 	int prio, static_prio;
+ 	list_t run_list;
+ 	prio_array_t *array;
+ 
+ 	unsigned long sleep_avg;
+ 	unsigned long sleep_timestamp;
+ 
+ 	unsigned long policy;
+ 	unsigned long cpus_allowed;
+ 	unsigned int time_slice, first_time_slice;
  
+ 	task_t *next_task, *prev_task;
+ 
+ 	struct mm_struct *mm, *active_mm;
  	struct list_head local_pages;
+ 
  	unsigned int allocation_order, nr_local_pages;
  
  /* task state */

</sched.h.rej>





--The GrandMaster
      <masterlee@digitalroadkill.net>
