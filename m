Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTGGK5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTGGK5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:57:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25987 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264888AbTGGK5G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:57:06 -0400
Date: Mon, 7 Jul 2003 07:13:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Auge Mike <tobe_better@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging , Tracing...
In-Reply-To: <Sea2-F643FKvfTFuO3b0001bb2a@hotmail.com>
Message-ID: <Pine.LNX.4.53.0307070708290.17801@chaos>
References: <Sea2-F643FKvfTFuO3b0001bb2a@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Auge Mike wrote:

> Hi all,
>
>       I have asked before few weeks about tracing the execution of the
> kernel or debugging it. Unfortunately, I faced some problems in using Kgdb,
> especially that the patch was not successful on my redhat 7.3.
>      Whatever, lets say that kgdb worked successfully, how can I trace the
> execution of “a specific system call” (lets say printf), so I can see how it
> works internally. Is there any other utility for that? How can I do that
> with kgdb?
>
>      Thanx for your help in advance.
>
> Yours,

printf() is not a system call. It is some procedure within the
'C' runtime library. Eventually, that library makes a call to
write() which is a kernel system call. You can use strace to see
the execution of all the system calls.

If you want to single-step through the 'C' runtime library, you
need to get their sources and compile them with the '-g' parameter
(for debugging). I don't know why you would want to do that, because
you would then have the sources so you can actually read the source
of what happens with a particular call.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

