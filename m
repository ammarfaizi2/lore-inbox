Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTJUPF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbTJUPF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:05:26 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:14492 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263115AbTJUPFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:05:22 -0400
Date: Tue, 21 Oct 2003 17:05:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 test8 patches.
Message-ID: <20031021150536.GA1457@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
8 bug fix patches for s390.

Short descriptions:
1) Base s390 fixes.
2) Common i/o layer fixes.
3) Pete Zaitcev complained about the dst_link_failure calls in the
   s390 network drivers. They can cause oopses in the tcp stack.
4) Dasd driver fixes.
5) Tape driver fixes.
6) More network driver fixes.
7) Fix reference counting problem of group device root objects.
   Is it worthwhile to add something like s390_root_dev_{register,unregister}
   to common code?
8) Fix copy_from_user / spin_lock problem in console drivers
   (DEBUG_SPINLOCK_SLEEP struck oil..)

One question: you said you only want stability bug fixes for now.
I conclude that I better not waste my and your time by sending in a
~9000 lines patch that replaces the old, broken 3270 driver with a
new one, right ?

blue skies,
  Martin.

