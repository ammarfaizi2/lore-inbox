Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTLRUlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265324AbTLRUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:41:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16005 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265297AbTLRUll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:41:41 -0500
Date: Thu, 18 Dec 2003 15:43:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeremy Kusnetz <JKusnetz@nrtc.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.23 is freezing my systems hard after 24-48 hours
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450569D3F6@exchange.nrtc.coop>
Message-ID: <Pine.LNX.4.53.0312181526050.13160@chaos>
References: <F7F4B5EA9EBD414D8A0091E80389450569D3F6@exchange.nrtc.coop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Jeremy Kusnetz wrote:

> > Please try the NMI oopser.
>
> Okay, the box just crashed.  It's acting differently then the
> previous crashes.  The previous crashed would lock up hard,
> no network, no output to screen, no sysrq.  I don't know if the
> NMI-watchdog is what's letting it get this far.
>
> This is the output to screen:
>
> BUG IN DYNAMIC LINKER ld.so: ../sysdeps/i386/dl-machine.h: 391:
> elf_machine_lazy_rel: Assertion `((reloc->r_info) & 0xff) == 7' failed!
>

PLEASE fix your mailer, the world uses '\n' after every 79 characters
or so, even though M$ invented the "screen-warp-around-technique".

The error is probably caused by the dynamic loader getting corrupt
or loaded incorrectly, either because of a disk error or because of
bad RAM. You probably see this immediately after init starts. It
is also possible for /etc/ld.so.cache to get corrupt and cause this.
To fix that, you could use `nash` or some statically-linked program
in place of init and then execute `ldconfig` after mv-ing /etc/ld.so.cache
out of the way.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


