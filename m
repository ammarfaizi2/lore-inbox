Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVGZEbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVGZEbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVGZEbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:31:25 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:35919 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S261641AbVGZEbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:31:23 -0400
Message-ID: <42E5BC9C.8060803@oracle.com>
Date: Mon, 25 Jul 2005 21:31:24 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>
Subject: setting task->ioprio from a kernel thread
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In OCFS2 there is currently an in-kernel heartbeat thread that really 
wants to communicate liveness to other nodes as quickly as possible by 
writing to a block device.  Setting aside the specific wisdom of a 
kernel heartbeat thread for a bit, has it been considered that kernel 
threads might want to set their io priority with the task->ioprio bits? 
  Neither set_task_ioprio() nor sys_ioprio_set() seem to be accessible 
to modules and open-coding it is clearly a bad idea.  Would the universe 
be opposed to a _GPL() export of, say, the sys_() interface?

- z
