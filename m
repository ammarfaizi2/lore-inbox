Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRCKWzn>; Sun, 11 Mar 2001 17:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRCKWzd>; Sun, 11 Mar 2001 17:55:33 -0500
Received: from ppp-97-248-an04u-dada6.iunet.it ([151.35.97.248]:30212 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129250AbRCKWzQ>;
	Sun, 11 Mar 2001 17:55:16 -0500
Message-ID: <XFMail.20010312011836.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.30.0103111038420.9486-100000@batman.zarzycki.org>
Date: Mon, 12 Mar 2001 01:18:36 +0100 (CET)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dave Zarzycki <dave@zarzycki.org>
Subject: Re: sys_sched_yield fast path
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
        Anton Blanchard <anton@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11-Mar-2001 Dave Zarzycki wrote:
> On Mon, 12 Mar 2001, Anton Blanchard wrote:
> 
>> Perhaps we need something like sched_yield that takes off some of
>> tsk->counter so the task with the spinlock will run earlier.
> 
> Personally speaking, I wish sched_yield() API was like so:
> 
> int sched_yield(pid_t pid);

Yes, You could do an API like this but it's not the mean of sched_yield().


> This would allow the thread wanting to acquire the spinlock to yield
> specifically to the thread holding the lock (assuming the pid of the lock
> holder was stored in the spinlock...) In fact, the the original lock owner
> could in theory yield back to the threading wanting to acquire the lock.

Everything happens inside a spinlock should be very fast otherwise the use of a
spinlock should be avoided.




- Davide

