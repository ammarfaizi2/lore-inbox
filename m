Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbULUOkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbULUOkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbULUOkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:40:46 -0500
Received: from mrout3.yahoo.com ([216.145.54.173]:12474 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S261763AbULUOkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:40:37 -0500
Message-ID: <41C835C7.2010203@gmail.com>
Date: Tue, 21 Dec 2004 20:10:07 +0530
From: Arun C Murthy <acmurthy@gmail.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: at_fork & at_exit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Im looking for linux equivalent of the FreeBSD calls:

1. at_fork

     typedef void
     (*forklist_fn)(struct proc *, struct proc *, int);

     int at_fork(forklist_fn func);

     The at_fork facility allows a kernel module to ensure that it is 
notified at any process fork.  The function func is called with the a 
pointer to the forking process's proc structure, a pointer to the 
child's process structure and a flag word, as used in rfork(2) to 
indicate the type of fork.

     If the requirement for notification is removed, then the function 
rm_at_fork() must be called with the exact func argument as the 
corresponding call to at_fork().

2. at_exit

     typedef void (exitlist_fn) (struct proc *);

     int at_exit(exitlist_fn func);

     The at_exit facility allows a kernel module to ensure that it is 
notified at any process exit.  The function func is called with the a 
pointer to the exiting process's proc structure.



  Specifically im on RHEL3... any pointers are appreciated...

thanks,
Arun

