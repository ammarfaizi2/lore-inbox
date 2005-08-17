Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVHQWyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVHQWyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHQWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:54:25 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:6655 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP
	id S1751308AbVHQWyY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:54:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Debugging kernel semaphore contention and priority inversion
Date: Wed, 17 Aug 2005 16:52:41 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0830FC77@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debugging kernel semaphore contention and priority inversion
Thread-Index: AcWjfl60hzjKoKH/RK6V85E26mC7zw==
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to know which task has a particular (struct semaphore *)
down()ed, leading to another task's down() blocking on it?

I'm trying to debug a priority inversion caused by potentially a real
low priority SCHED_OTHER task (potentially a kernel thread like
kjournald) holding an inode->i_sem semaphore for a file that is blocking
a write() from a high-priority (50) SCHED_FIFO task.

It would be helpful to get a kernel stacktrace for the culprit too.

Thanks

- Bhavesh

Ps: ideally I would like to do this from a module/probe I can insert in
a system that is stuck in this state, because I don't want to Heisenberg
the setup with a kdb or otherwise instrumented kernel.

 

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com


