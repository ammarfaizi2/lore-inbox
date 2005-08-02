Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVHBJW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVHBJW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVHBJW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:22:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2758 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261375AbVHBJW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:22:58 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: vinay hegde <thisismevinay@yahoo.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need help regarding kernel threads 
In-reply-to: Your message of "Tue, 02 Aug 2005 09:57:51 +0100."
             <20050802085751.55408.qmail@web8407.mail.in.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Aug 2005 19:22:50 +1000
Message-ID: <11025.1122974570@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 09:57:51 +0100 (BST), 
vinay hegde <thisismevinay@yahoo.co.in> wrote:
>How to differentiate kernel threads from normal
>processes inside the Linux kernel code? 

The Linux Kernel Debugger (ftp://oss.sgi.com/projects/kdb/download/v4.4)
distinguishes between idle tasks, sleeping system daemons and the rest
(typically user tasks).  An idle task has pid 0, a sleeping system
daemon has a NULL mm field and is in S state, everything else is
treated as a normal task.

Download the latest kdb common patch and look at function
kdb_task_state_char.

