Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280808AbRKGP7u>; Wed, 7 Nov 2001 10:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280828AbRKGP7k>; Wed, 7 Nov 2001 10:59:40 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12470 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280808AbRKGP70>; Wed, 7 Nov 2001 10:59:26 -0500
Message-ID: <3BE95A1B.80B68D65@redhat.com>
Date: Wed, 07 Nov 2001 10:58:19 -0500
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 stress testing
In-Reply-To: <3BE83CB8.2A8C38FB@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Matthews wrote:
 
> The problem kernel is statically linked, with HIGHMEM=64G, SMP, NFS
> client and server V3, eepro100, and the sym53c8xx driver.  The machine
> is an 8xPIII configured as 8G/16G.
> 
> The machine ran the test suite for ~17 hours, and then gradually began
> to slow down to the point where key presses at a virtual console took
> many seconds to echo.  Eventually, the machine became unresponsive.  The
> test harness clock is still ticking, and I can change VC's, but that's
> about it.  Magic Sysrq doesn't give me anything except the name of the
> corresponding command.  The machine does not appear to have generated
> any oops output.

Well, this is very strange indeed.  Sometime during the night, this
machine came back to life and continued executing the test suite. 
According to the logs, it ran the tests for approximately 7 hours, then
became unresponsive again.  It is currently in the "zombie" state
described above: Magic Sysrq doesn't give anything but the name of the
command, and a shell I have opened on a VC won't echo any characters.  I
guess we'll see if it resurrects itself again.

Manfred mentioned that Sysrq tries to take the task queue spinlock.  Is
there some segment of code in the kernel which would cause a process to
grab the task queue spinlock and hold it for a long time under heavy
memory contention?

I should mention that the job mix induced by the test suite would be
considered unreasonable in a normal environment.

-- 
Bob Matthews
Red Hat, Inc.
