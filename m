Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267151AbUBSKEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267155AbUBSKEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:04:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:11761 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267151AbUBSKEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:04:53 -0500
Date: Thu, 19 Feb 2004 15:35:50 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread
Message-ID: <20040219100549.GA27018@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040218231322.35EE92C05F@lists.samba.org> <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com> <20040219001011.6245f163.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219001011.6245f163.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:12:19AM +0000, Andrew Morton wrote:
> However, if that wake_up_process() comes too early we'll just flip the new
> thread out of TASK_INTERUPTIBLE into TASK_RUNNING and the schedule() in
> kthread() will fall straight through.  So perhaps we can simply remove the
> wait_task_inactive()?

If wake_up_process() comes too early (when the target task is still
in TASK_RUNNING state), then won't wake_up_process() be a no-op?
In which case, the target kthread will miss a wake-up event 
(kthread_start/kthread_stop)?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
