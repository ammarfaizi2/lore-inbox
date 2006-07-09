Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWGILqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWGILqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWGILqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:46:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58470 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030455AbWGILqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:46:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HU50V/xquhnXgy07t6SU6BqqjoBicqCnel06ZAIL0mCMuaftfDz4jXEA5PY9a2moSbLUBHznB0Oj9qBCS+q8M5l8ORAe02F9Rf5iM4N17wqHrid+LV/ZPRr5rwLsr9Rfqsy73hh+Ntam+Tfh+sAuvkxNfOf7CtEklNv5sONwOLg=
Date: Sun, 9 Jul 2006 15:52:33 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: linux-2.6.17-mm6: can not stop machine: bad spinlock magic
Message-Id: <20060709155233.6dfe61bd.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this bug only on linux-2.6.17-mm6, not on 2.6.18-rc1-mm1.

But this bug happened very rare, and may be I'll see it later,
so I report it just in case:

$sudo /sbin/poweroff
...
* Stopping syslog-ng
BUG: soft lockup detected on CPU#0!
show_trace
dump_stack
softlockup_tick
run_local_timers
update_process_times
timer_interrupt
handle_IRQ_event
handle_level_irq
do_IRQ
common_interrupt
ktime_get_ts
copy_process
do_fork
sys_fork
