Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSHWMDH>; Fri, 23 Aug 2002 08:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSHWMDG>; Fri, 23 Aug 2002 08:03:06 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:455 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S318767AbSHWMDG>; Fri, 23 Aug 2002 08:03:06 -0400
Message-Id: <200208231207.VAA13142@cttsv008.ctt.ne.jp>
Date: Fri, 23 Aug 2002 13:58:01 +0900
To: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
From: Kerenyi Gabor <wom@tateyama.hu>
Subject: Re: interrupt handler
Organization: Tateyama Hungary Ltd.
X-Mailer: Opera 5.12 build 932
X-Priority: 3 (Normal)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/23/2002 8:58:20 PM, "sanket rathi" <sanket@linuxmail.org> wrote:

>hi,
>Can i use spin lock in the interrupt handler for a singlre processor machine. because books says u can not use locks 
>but spin lock is some thing diffrent 

Yes you can. Spinlocks will be compiled in if you choose SMP even on single processor machine.
But look at the documentation in the kernel source.
I think "lock" in your message is a semaphore in real life.

Spinlocks never sleep - they don't perform task switch and you can use them anywhere, while semaphores
can sleep and you can use them only in user context (not in interrupt or bottom half)

Gabor


