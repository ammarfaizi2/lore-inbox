Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTIEION (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIEION
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:14:13 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30212 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262342AbTIEIOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:14:09 -0400
Message-ID: <3F5847B7.9070308@aitel.hist.no>
Date: Fri, 05 Sep 2003 10:22:15 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4-mm5 SMP got stuck when configuring the NIC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test4-mm5 seems to work on UP, but got stuck on SMP when the
initscripts ran pump.

It responded to sysrq+S, & sysrq+U,
so it seems block io was still working.
There was no fsck on the next boot into plain 2.6.0-test4.

sysrq+P showed:
Pid 38, comm: pump
EIP at __mod_timer+0x34/0x270
do_IRQ
common_interrupt
del_timer
del_timer_sync
schedule_timeout
process_timeout
dev_close
dev_change_flags
devinet_ioctl
inet_ioctl
sock_ioctl
syscall_call
auth_domain_drop

sysrq+T
showed pump as the R process, syslogd Z, and others S.

I'll try without the elv-insertion-fix thing later today.

Helge Hafting

