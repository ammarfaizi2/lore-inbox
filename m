Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTEGPqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTEGPqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:46:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56962 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264066AbTEGPqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:46:04 -0400
Date: Wed, 7 May 2003 12:00:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: petter wahlman <petter@bluezone.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052321673.3727.737.camel@badeip>
Message-ID: <Pine.LNX.4.53.0305071147510.12652@chaos>
References: <1052321673.3727.737.camel@badeip>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, petter wahlman wrote:

>
> It seems like nobody belives that there are any technically valid
> reasons for hooking system calls, but how should e.g anti virus
> on-access scanners intercept syscalls?
> Preloading libraries, ptracing init, patching g/libc, etc. are
  ^^^^^^^^^^^^^^^^^^^
                    |________  Is the way to go. That's how
you communicate every system-call to a user-mode daemon that
does whatever you want it to do, including phoning the National
Security Administrator if that's the policy.

> obviously not the way to go.
>

Oviously wrong.

Also, there are existing system calls that are not in use.
You can modify your copy of a kernel for whatever you want.
Example system calls that simply return -ENOSYS are
break, stty, gtty, prof, acct, lock, and mpx. That should
be enough entry-points to muck with.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

