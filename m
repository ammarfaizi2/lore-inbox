Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263568AbUEEHpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUEEHpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 03:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUEEHpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 03:45:25 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:48786 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263568AbUEEHpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 03:45:24 -0400
Message-ID: <40989B6B.4000204@yahoo.com.au>
Date: Wed, 05 May 2004 17:44:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ashok Raj <ashok.raj@intel.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       pj@sgi.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj blessed)
 Patch [6/7]
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org>
In-Reply-To: <20040504225907.6c2fe459.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:

> It appears that x86's arch_init_sched_domains() is blindly assuming that
> each CPU's migration thread is running and is pointed to by
> rq->migration_thread.  But from the above you'll see that CPU0's migration
> thread is running, but CPU1's has never been created, hence the
> null-pointer deref.
> 

The assumption is that the migration thread is running unless
cpu_is_offline is true. I think this is still OK, I can have
another look at it if anyone thinks otherwise.

As far as arch_init_sched_domains goes, it can be run as late
as you like if it needs to be moved.
