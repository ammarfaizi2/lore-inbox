Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSCJU3z>; Sun, 10 Mar 2002 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293222AbSCJU3g>; Sun, 10 Mar 2002 15:29:36 -0500
Received: from ns.suse.de ([213.95.15.193]:41732 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293224AbSCJU3e>;
	Sun, 10 Mar 2002 15:29:34 -0500
Mail-Copies-To: never
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <1015784104.1261.8.camel@phantasy>
From: Andreas Jaeger <aj@suse.de>
Date: Sun, 10 Mar 2002 21:29:31 +0100
In-Reply-To: <1015784104.1261.8.camel@phantasy> (Robert Love's message of
 "10 Mar 2002 13:15:03 -0500")
Message-ID: <u8zo1g9nf8.fsf@gromit.moeb>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> writes:

> Linus,
>
> I have updated the patch a bit and resycned to 2.5.6.  Are you
> interested?  I believe a user interface for setting task CPU affinity is
> useful and completes the rest of our sched_* syscalls.  A syscall
> implementation seems to be what everyone wants (I have a proc-interface,
> too...)

Please add the procinterface also!  I've found it today (for 2.4.18)
and it's much easier to use with existing programs.

Andreas

> This patch implements
>
>         int sched_set_affinity(pid_t pid, unsigned int len,
>                                unsigned long *new_mask_ptr);
>
>         int sched_get_affinity(pid_t pid, unsigned int *user_len_ptr,
>                                unsigned long *user_mask_ptr)
>
> which set and get the cpu affinity (task->cpus_allowed) for a task,
> using the set_cpus_allowed function in Ingo's scheduler.  The functions
> properly support changes to cpus_allowed, implement security, and are
> well-tested.
>
> They are based on Ingo's older affinity syscall patch and my older
> affinity proc patch.
>
> Comments?

Please add it for all archs - this is not only interesting for x86,
Andreas

[...]
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
