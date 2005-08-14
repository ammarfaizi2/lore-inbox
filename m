Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVHNMlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVHNMlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVHNMlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:41:50 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:25444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932504AbVHNMlu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:41:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=anbELyUhunPgwxD4oio7fVmoVG9ZXtV6pCSX49s9iDD1tXiFCcySyJFjNX2gEauHZsUci6L7phg0bgovWD0NSNJW5xM/Hr93bNog//5UXzCZlrd9x5UJpBFtTqxvvo7rYdk7wOPSySA2ju3i6GZfkA5Nr3mOYbhm8M728RcbVJQ=
Message-ID: <f03ab5ae05081405411da7f70@mail.gmail.com>
Date: Sun, 14 Aug 2005 15:41:49 +0300
From: Samer Sarhan <samersarhan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Changing thread_info->task, does it harm?
Cc: Ahmed Mohamed Tarek <ahmadtarek@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I had a design problem of a Linux module (Linux 2.6.11) that lead me to do this:

int work_fn(void* data);
task_t my_task;
task_t* kthread = kthread_create(work_fn, NULL, "Task 1");
// assume kthread create was successfully...
my_task = *kthread;
// change what current maceo points to...
kthread->thread_info->task = &my_task;
...
...
wake_up_process(&my_task);
...
..

well... is it dangerous to change what current macro points to through
changing thread_info->task?

Please help!
Thanks for help in advance!
-- 
===========
Samer Sarhan.
"To understand recursion, you need to understand recursion."
http://samersarhan.blogspot.com
