Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUAFX3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUAFX3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:29:21 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:28175 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP id S265470AbUAFX3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:29:19 -0500
Date: Wed, 7 Jan 2004 00:29:10 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: <linux-kernel@vger.kernel.org>,
       <valgrind-developers@lists.sourceforge.net>
Subject: Re: 2.4.24 asm/timex.h
Message-ID: <Pine.LNX.4.33.0401070027540.13426-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Eyal Lebedinsky wrote:

> Building valgrind, it includes <linux/timex.h> and then tries
> to use the adjtimex syscall. This ends up with an undefined
> error for 'cpu_has_tsc'. This did not happen with earlier
> kernels.
>
> In file included from /usr/include/linux/timex.h:152,
>                  from vg_unsafe.h:66,
>                  from vg_syscalls.c:35:
> /usr/include/asm/timex.h: In function `get_cycles':
> /usr/include/asm/timex.h:44: `cpu_has_tsc' undeclared (first use in this
> function)

cpu_has_tsc is defined in cpufeature.h, so probably adding:
#include <asm/cpufeature.h>
to the include/asm-i386/timex.h would help.

I don't have 2.4.25-pre handy, so I can't test it (nor send the patch) at
the moment.

pkot
PS. Sorry for the duplicate, forgot to cc the lists.
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku






