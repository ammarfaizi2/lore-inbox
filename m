Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTE0ML1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTE0ML1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:11:27 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:29828 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263317AbTE0ML0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:11:26 -0400
Date: Tue, 27 May 2003 08:23:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: "esp.o" build error in 2.5.70
Message-ID: <Pine.LNX.4.44.0305270822210.32363-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  again, the tail end of "make allyesconfig" for 2.5.70 on RH 9:

  CC      drivers/char/esp.o
drivers/char/esp.c:110: warning: type defaults to `int' in declaration of `DECLARE_TASK_QUEUE'
drivers/char/esp.c:110: warning: parameter names (without types) in function declaration
drivers/char/esp.c: In function `rs_stop':
drivers/char/esp.c:225: warning: implicit declaration of function `save_flags'
drivers/char/esp.c:225: warning: implicit declaration of function `cli'
drivers/char/esp.c:232: warning: implicit declaration of function `restore_flags'
drivers/char/esp.c:220: warning: `flags' might be used uninitialized in this function
drivers/char/esp.c: In function `rs_start':
drivers/char/esp.c:238: warning: `flags' might be used uninitialized in this function
drivers/char/esp.c: In function `rs_sched_event':
drivers/char/esp.c:281: warning: implicit declaration of function `queue_task'
drivers/char/esp.c:281: `tq_esp' undeclared (first use in this function)
drivers/char/esp.c:281: (Each undeclared identifier is reported only once
drivers/char/esp.c:281: for each function it appears in.)
drivers/char/esp.c:282: warning: implicit declaration of function `mark_bh'
drivers/char/esp.c:282: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c: In function `receive_chars_pio':
drivers/char/esp.c:324: warning: implicit declaration of function `sti'
drivers/char/esp.c:377: structure has no member named `tqueue'
drivers/char/esp.c:377: `tq_timer' undeclared (first use in this function)
drivers/char/esp.c: In function `receive_chars_dma_done':
drivers/char/esp.c:452: structure has no member named `tqueue'
drivers/char/esp.c:452: `tq_timer' undeclared (first use in this function)
drivers/char/esp.c: In function `check_modem_status':
drivers/char/esp.c:646: warning: implicit declaration of function `schedule_task'
drivers/char/esp.c: In function `do_serial_bh':
drivers/char/esp.c:775: warning: implicit declaration of function `run_task_queue'
drivers/char/esp.c:775: `tq_esp' undeclared (first use in this function)
drivers/char/esp.c: In function `autoconfig':
drivers/char/esp.c:2453: warning: `__check_region' is deprecated (declared at include/linux/ioport.h:113)
drivers/char/esp.c: In function `espserial_init':
drivers/char/esp.c:2511: warning: implicit declaration of function `init_bh'
drivers/char/esp.c:2511: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c:2642: structure has no member named `routine'
drivers/char/esp.c:2644: structure has no member named `routine'
drivers/char/esp.c: In function `espserial_exit':
drivers/char/esp.c:2716: warning: implicit declaration of function `remove_bh'
drivers/char/esp.c:2716: `ESP_BH' undeclared (first use in this function)
drivers/char/esp.c: At top level:
drivers/char/esp.c:110: warning: `DECLARE_TASK_QUEUE' declared `static' but never defined
make[2]: *** [drivers/char/esp.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2




rday

