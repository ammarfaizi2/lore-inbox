Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUFPGNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUFPGNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 02:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUFPGNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 02:13:42 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:50631 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266182AbUFPGNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 02:13:40 -0400
Message-ID: <40CFE50D.10308@t-online.de>
Date: Wed, 16 Jun 2004 08:13:33 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gmishkin@bu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: ld segfault at end of 2.6.6 compile
References: <1087352698.8671.23.camel@amsa>
In-Reply-To: <1087352698.8671.23.camel@amsa>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bKBfvBZaYeiVoMFiRXh3U3zBy9iQOD6CQXDQjLxly6e5+GQ4XlQdUd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Mishkin wrote:
> I'm getting the
> 
> make: *** [.tmp_vmlinux1] Error 139
> 
> problem with kernel 2.6.6.  It works fine on one of my computer, but not
> the other.
> 
> The full line is
> 
> ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> --start-group  usr/built-in.o arch/i386/kernel/built-in.o 
> arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
> lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o 
> sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/power/built-in.o 
> net/built-in.o --end-group  -o .tmp_vmlinux1
> make: *** [.tmp_vmlinux1] Error 139
> 

Error 139 is a SEGV somewhere in a subprocess. Linker errors
like this might be an indicator for problems with your physical
memory.

My suggestion would be to enter your PC's BIOS setup at boot
time and verify the RAM access timing. Maybe it was set too
optimistic.


Good luck

Harri
