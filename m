Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSIXSYz>; Tue, 24 Sep 2002 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSIXSYz>; Tue, 24 Sep 2002 14:24:55 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:24374 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S261747AbSIXSYx>;
	Tue, 24 Sep 2002 14:24:53 -0400
Subject: Re: 2.4.19: oops in ide-scsi
From: James Stevenson <james@stev.org>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87n0q8tcs8.fsf@ceramic.fifi.org>
References: <87n0q8tcs8.fsf@ceramic.fifi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Sep 2002 19:26:25 +0100
Message-Id: <1032891985.2035.1.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i am glad somebody else sees the same crash as me the
request Q gets set to NULL for some reson then tries to
increment a stats counter in the null pointer.
i know what the bug is i just dont know how to fix it :>

> 
> >>ebx; c089c000 <_end+587294/64ed294>
> >>ecx; c0305744 <ide_hwifs+364/21e8>
> >>esi; c11c3ac0 <_end+eaed54/64ed294>
> >>edi; f6e8db4b <END_OF_CODE+30541cac/????>
> >>ebp; c03058d4 <ide_hwifs+4f4/21e8>
> >>esp; c02a3f04 <init_task_union+1f04/2000>
> 
> Trace; c01b002c <ide_intr+f8/164>
> Trace; c682046c <[ide-scsi]idescsi_pc_intr+0/23c>
> Trace; c010a394 <handle_IRQ_event+50/7c>
> Trace; c010a586 <do_IRQ+a6/ec>
> Trace; c010caf8 <call_do_IRQ+5/d>
> Trace; c0106c7c <default_idle+2c/34>
> Trace; c68c8415 <[apm]apm_cpu_idle+109/13c>
> Trace; c68c830c <[apm]apm_cpu_idle+0/13c>
> Trace; c0106c50 <default_idle+0/34>
> Trace; c0106ce2 <cpu_idle+3e/54>
> Trace; c0105000 <_stext+0/0>
> Trace; c010504f <rest_init+4f/50>
> 
> Code;  c68204e0 <[ide-scsi]idescsi_pc_intr+74/23c>
> 00000000 <_EIP>:
> Code;  c68204e0 <[ide-scsi]idescsi_pc_intr+74/23c>   <=====
>    0:   ff 47 18                  incl   0x18(%edi)   <=====
> Code;  c68204e3 <[ide-scsi]idescsi_pc_intr+77/23c>
>    3:   8b 85 f0 00 00 00         mov    0xf0(%ebp),%eax
> Code;  c68204e9 <[ide-scsi]idescsi_pc_intr+7d/23c>
>    9:   8b 40 04                  mov    0x4(%eax),%eax
> Code;  c68204ec <[ide-scsi]idescsi_pc_intr+80/23c>
>    c:   50                        push   %eax
> Code;  c68204ed <[ide-scsi]idescsi_pc_intr+81/23c>
>    d:   6a 01                     push   $0x1
> Code;  c68204ef <[ide-scsi]idescsi_pc_intr+83/23c>
>    f:   e8 24 fd ff ff            call   fffffd38 <_EIP+0xfffffd38> c6820218 <[ide-scsi]idescsi_end_request+0/254>
> 
> <6> <0>Kernel panic: Aiee, killing interrupt handler!
> 1+0 records in
> 1+0 records out
> 
> 1 warning issued.  Results may not be reliable.


