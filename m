Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVAOLZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVAOLZk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAOLZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 06:25:40 -0500
Received: from web8509.mail.in.yahoo.com ([202.43.219.171]:47276 "HELO
	web8509.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262259AbVAOLZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 06:25:32 -0500
Message-ID: <20050115112529.9759.qmail@web8509.mail.in.yahoo.com>
Date: Sat, 15 Jan 2005 11:25:29 +0000 (GMT)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Accessing runqueue from device driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am visulaizing a one of the use of char device
driver.
I need to write a char device which will prompt me by
printing on my pseudo terminal if there is any zombie
element in a runqueue on a specific processor. 

Is it possible to keep a track on runqueue through a
function defined in a char device ? If I provied the
information about zombies via /proc filesystem, then a
user needs to read file again and again and would not
be able to keep a constant watch on the zombies. Is it
possible that my char device goes to sleep on a
waitqueue and wakes up's only when a zombies process
is present in a runqueue and then after giving details
of that zombie process, my char device driver again
goes to sleep and wait for new zombies in a runqueue.

Could anyone guide me is the above thought can be
implemented.


Can anybody guide me that how to use this_rq in a
kernel module ? I get following error:

CharRunQueue.o: unresolved symbol this_rq

Including sched.h wonot help as macro is defined in
sched.c. If I include sched.c, then I get lots of
errors which are as follows:
CharRunQueue.o: unresolved symbol immediate_bh
CharRunQueue.o: unresolved symbol timer_bh
CharRunQueue.o: unresolved symbol __switch_to
CharRunQueue.o: unresolved symbol cpu_gdt_table
CharRunQueue.o: unresolved symbol __mmdrop
CharRunQueue.o: unresolved symbol tqueue_bh
CharRunQueue.o: unresolved symbol default_ldt
CharRunQueue.o: unresolved symbol show_trace_task
CharRunQueue.o: unresolved symbol init_timervecs
CharRunQueue.o: unresolved symbol __put_task_struct

Please let me know where I am going wrong.


Regards
Dinesh


________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
