Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbRHEXOw>; Sun, 5 Aug 2001 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbRHEXOm>; Sun, 5 Aug 2001 19:14:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36622 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264669AbRHEXOX>; Sun, 5 Aug 2001 19:14:23 -0400
Subject: Re: Problems with 2.4.7-ac6 + SMP + FastTrak100
To: arnvid@karstad.org (Arnvid Karstad)
Date: Mon, 6 Aug 2001 00:16:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010806005905.B871.ARNVID@karstad.org> from "Arnvid Karstad" at Aug 06, 2001 01:03:59 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TX8D-00005G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even the 2.4.7 vanilla did die.. I booted a 2.4.5 perfectly before.. and
> 2.2.19 SMP
> Gonna try them both again now

Does 2.4.6 fail ?

> CPU:    0
> EIP:    0010:[<c010bef8>]
> EFLAGS: 00010206

Crashed doing FPU setup

Your boot CPU ends "cmov mmx" (ie Pentium II)

> bogomips        : 614.40

> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
> cmov pat pse36 mmx fxsr
> bogomips        : 616.03

And the second processor has fxsr (ie SSE - preventium III)

It looks like that is tripping a bug that got re-introduced in 2.4.6 or
2.4.7 (hence I asked which failed). That would explain why there haven't
been millions of reports

Alan
