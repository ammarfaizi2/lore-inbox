Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTGKOh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTGKOh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:37:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262385AbTGKOhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:37:53 -0400
Date: Fri, 11 Jul 2003 10:52:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "David D. Hagood" <wowbagger@sktc.net>
cc: hzhong@cisco.com, "'Alan Stern'" <stern@rowland.harvard.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers?
In-Reply-To: <3F0EC5EF.7090002@sktc.net>
Message-ID: <Pine.LNX.4.53.0307111039400.2708@chaos>
References: <01c701c34766$4706cc50$743147ab@amer.cisco.com> <3F0EC5EF.7090002@sktc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, David D. Hagood wrote:

> Hua Zhong wrote:
>
> > Not always true. In some cases you know how to handle: just return
> > without doing anyting.
>
> That is NOT an error condition - the API specifically allows NULL to be
> passed in, and specifically states that no action will be taken in that
> case.
>
> But consider the following code:
>
> sscanf(0,0);
>
> That IS an error condition - both the string to scan and the format
> string are NULL. In this case sscanf should return EITHER 0 (no items
> matched) or better still -1 (error).
>

But it does neither. Instead, it seg-faults your code!

The problem lies with the original question. The question
referred to "Style" (look at the subject-line). It is
not a question about style, but a question about utility
and design. Style has nothing to do with it.

If you are writing code for an embedded system, the code
must always run even if RAM got trashed from alpha particles
or EMP. In that case, you trap every possible condition and
force a restart off a hardware timer, refreshing everything in
RAM from PROM or NVRAM.

If you are writing code to examine the contents of sys_errlist[],
prior to adding another error-code, then you don't check anything
and it's file-name is probably a.out, compiled from xxx.c.

So, the extent to which one checks for exceptions and provides
utility for handling exceptions depends upon the code design, not
it's style.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

