Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSJRQqa>; Fri, 18 Oct 2002 12:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265235AbSJRQqa>; Fri, 18 Oct 2002 12:46:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23168 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265228AbSJRQq3>; Fri, 18 Oct 2002 12:46:29 -0400
Date: Fri, 18 Oct 2002 12:52:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell Coker <russell@coker.com.au>
cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <200210181838.56735.russell@coker.com.au>
Message-ID: <Pine.LNX.3.95.1021018124612.3407A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think, if you are going to reserve a system-call for "security",
all you need is one. And, I think you need to reserve one.

By default, it calls a dummy procedure that just returns "okay".
The security folks can write a module that interfaces with this
one security-hook. You only need one such hook because a system
call can get a pointer to some structure that tells it what to
do. You don't need "N" system calls, only one.

Such a simple hook is quite likely the way-to-go. No cruft in
the kernel, and upon some reported error, the development people
can say; "Unload the security module and see if you still have
the error..."

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

