Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSC0WdD>; Wed, 27 Mar 2002 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSC0Wcw>; Wed, 27 Mar 2002 17:32:52 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:62970 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S293076AbSC0Wch>; Wed, 27 Mar 2002 17:32:37 -0500
Date: Wed, 27 Mar 2002 14:32:31 -0800
From: Chris Wright <chris@wirex.com>
To: Stephen Baker <stbaker@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Patch; setpriority
Message-ID: <20020327143231.A19240@figure1.int.wirex.com>
Mail-Followup-To: Stephen Baker <stbaker@cisco.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CA232A1.7040702@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Baker (stbaker@cisco.com) wrote:
> 
> This patch will allow a process or thread to changes it's priority 
> dynamically based on it's capabilities.  In our case we wanted to use 
> threads with Linux.  To have true priorities we need root to use 
> SCHED_FIFO or SCHED_RR; in many case root access is not allowed but we 
> still wanted priorities.  So we started using setpriority to change a 
> threads priority.  Now we used nice values from 19 to 0 which did not 
> require root access.  In some cases a thread need to raise it's nice 
> level and this would fail.  I also saw a note man renice(8) that said 
> this bug exists.

hmm, SUS v3 seems to disagree.

"Only a process with appropriate privileges can lower its nice value."

and with this patch setpriority(2) is now inconsistent with nice(2)
(albeit i don't know how much longer that interface will persist in arch
independent portion of the kernel based on the comments surrounding it).

-chris
