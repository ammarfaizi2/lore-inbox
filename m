Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbULJRn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbULJRn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULJRn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:43:58 -0500
Received: from holomorphy.com ([207.189.100.168]:32658 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261764AbULJRn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:43:56 -0500
Date: Fri, 10 Dec 2004 09:43:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210174342.GQ2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx> <20041210163247.GM2714@holomorphy.com> <1102697553.3306.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102697553.3306.91.camel@tglx.tec.linutronix.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 08:32 -0800, William Lee Irwin III wrote:
>> It appears the net functional change here is the reentrancy prevention;
>> the choice of tasks is policy. The functional change may be accomplished
>> with the following:

On Fri, Dec 10, 2004 at 05:52:33PM +0100, Thomas Gleixner wrote:
> Your patch would call yield() with the lock held. On an UP machine you
> end up in the same code, as spin_locks are NOPs except for the preempt
> part.
> It's now obsolete by the fixes which were done by Andrea. 
> I'm wondering why he did not post the final version. Andrea ???
> Attached is the latest working and tested patch. It contains Andrea's
> fixes to the oom invocation and my modifications to the selection whom
> to kill.
> This should really go into mainline.

ARGH, preempt.


-- wli
