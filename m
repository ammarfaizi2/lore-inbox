Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUB2Ryr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbUB2Ryr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:54:47 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:3765 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262088AbUB2Ryo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:54:44 -0500
Date: Mon, 01 Mar 2004 01:54:29 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>, linux-kernel@vger.kernel.org
Subject: Re: __buggy_fxsr_alignment() not found.
References: <Pine.GSO.3.96.SK.1040229200132.17294A-100000@univ.uniyar.ac.ru>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr34703sf4evsfm@smtp.pacific.net.th>
In-Reply-To: <Pine.GSO.3.96.SK.1040229200132.17294A-100000@univ.uniyar.ac.ru>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 20:02:12 +0300 (MSK), Igor Yu. Zhbanov <bsg@uniyar.ac.ru> wrote:

> Hello!
> My system is:
> AMD K6-II 450
> Linux-2.4.24
> glibc-2.2.5
>
> I cannot compile 2.4.24 kernel because linker says:
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'
>
> It's prototype is in inculude/asm-i386/bugs.h:
> -----
> /* Enable FXSR and company _before_ testing for FP problems. */
>         /*
>          * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>          */
>         if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
>               extern void __buggy_fxsr_alignment(void);
>               __buggy_fxsr_alignment();
> -----
> But there is no realisation of this function in source files.
> When I comment the lines above, everything works.
>
> Please CC to Reply-to.
>

Please post your .config

Regards
Michael
