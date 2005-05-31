Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVEaJEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVEaJEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEaJEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:04:09 -0400
Received: from fmr19.intel.com ([134.134.136.18]:20192 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261396AbVEaJEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:04:05 -0400
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
From: Shaohua Li <shaohua.li@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ashok Raj <ashok.raj@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <429C253E.10004@yahoo.com.au>
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
	 <20050531010030.A5239@unix-os.sc.intel.com>
	 <1117528509.3957.3.camel@linux-hp.sh.intel.com>
	 <429C253E.10004@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 31 May 2005 17:11:06 +0800
Message-Id: <1117530667.4025.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 18:50 +1000, Nick Piggin wrote:
> Shaohua Li wrote:
> 
> > I must be over considering. Ok, how does this updated one look?
> > 
> > 
> 
> Looks like you've found a race, alright. Nice work!
> 
> I think it would be preferable to do the check in kernel/fork.c,
> after the tasklist lock is taken (and you'll need to rediff the
> patch for the -mm tree).
It seems there is still a race between copy_process and wake_up_new_task
to me (cpu offline after copy_process). Am I missing anything?

Thanks,
Shaohua

