Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUGICwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUGICwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGICwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:52:14 -0400
Received: from holomorphy.com ([207.189.100.168]:21225 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263555AbUGICwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:52:04 -0400
Date: Thu, 8 Jul 2004 19:51:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040709025151.GV21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	"David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EE06B1.1090202@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>> The parent's regs (stored in current_thread_info() at trap time,
>> and also needed by copy_thread() processing) will also be garbage
>> since we're avoiding the fork syscall trap.
>> In short, this won't work :)
>> This is why I use kernel_thread().  Why is that so bad?

On Fri, Jul 09, 2004 at 12:45:05PM +1000, Nick Piggin wrote:
> We could make CLONE_IDLETASK clones not do the wakeup?
> Ingo? I guess an alternative is to have the arch explicitly
> make a call to dequeue it.

This is all just context switching and bootstrap ordering, but I really
have other vastly more urgent things to do at the moment than cleanups.
Please present a self-contained fixed-up init_idle() cleanup for me to
testboot. Even the one in -mm is not so, as it depends on later patches
to even compile.


-- wli
