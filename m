Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWEHXyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWEHXyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 19:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWEHXyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 19:54:36 -0400
Received: from fmr20.intel.com ([134.134.136.19]:29156 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750836AbWEHXyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 19:54:36 -0400
Subject: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: kernel@kolivas.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Intel
Date: Mon, 08 May 2006 16:18:18 -0700
Message-Id: <1147130298.30649.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

As a result of the patch "sched:dont decrease idle sleep avg" 
introduced after 2.6.15, there is a 4% drop in Volanomark 
throughput on our Itanium test machine.  
Probably the following happened:
Compared to previous code, this patch slightly increases 
the the priority boost when a job is woken up.
This adds priority spread and variations to the wait time of jobs
on run queue if we have a lot of similar jobs in the system.

See patch:
http://www.kernel.org/git/?
p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 

Regards,
Tim 


