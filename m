Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVGaF12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVGaF12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGaF12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:27:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbVGaF10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:27:26 -0400
Date: Sat, 30 Jul 2005 22:26:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
Message-Id: <20050730222624.73337021.akpm@osdl.org>
In-Reply-To: <42EC5451.7010907@yahoo.com.br>
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
	<105c793f05072507426fb6d4c9@mail.gmail.com>
	<42E59E0E.5030306@yahoo.com.br>
	<20050726003322.1bfe17ee.akpm@osdl.org>
	<42E7A153.6060307@yahoo.com.br>
	<20050727105005.30768fe3.akpm@osdl.org>
	<42E85E6E.2020105@yahoo.com.br>
	<42EC5451.7010907@yahoo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
>
> udev          S 00000002     0  1312      1                1224 (NOTLB)
>  c1653f4c 00000082 c1653f3c 00000002 00000001 00000040 c1653f64 c1653f0c
>         c016611b bfec96a8 c1653f0c 00000040 00000000 00000361 000241ed
>  c13fb520
>         00000001 00001a7e 98f9769f 00000002 c146e520 df5da020 df5da148
>  c13fbf60
>  Call Trace:
>   [<c016611b>] cp_new_stat+0x15f/0x17a
>   [<c0352a74>] schedule_timeout+0x54/0xa2
>   [<c01274ce>] process_timeout+0x0/0x9
>   [<c01275c4>] sys_nanosleep+0xdd/0x18e
>   [<c0102e85>] syscall_call+0x7/0xb

Well there's your delay: you've started running userspace and udev is
running.  Yes, it takes a long time.

What makes you think this isn't normal behaviour?  Do other kernels behave
differently with the same userspace setup?
