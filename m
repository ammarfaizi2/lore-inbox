Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSBCM4y>; Sun, 3 Feb 2002 07:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbSBCM4p>; Sun, 3 Feb 2002 07:56:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34751 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287048AbSBCM4Z>;
	Sun, 3 Feb 2002 07:56:25 -0500
Date: Sun, 3 Feb 2002 15:54:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alpha Beta <abbashake007@lycos.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qn: kernel_thread() and init
In-Reply-To: <BNBIFONAELMBOAAA@mailcity.com>
Message-ID: <Pine.LNX.4.33.0202031552250.11216-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Alpha Beta wrote:

> But at that time, the process 0 which calls kernel_thread is executing
> in Kernel mode, so why should some process in kernel mode make a
> system call??

it's mainly done to get a clean ptregs variable the new thread can be
created from. Just calling do_fork() is not enough. It's also a good test
of the syscall return path.

	Ingo

