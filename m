Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286237AbRLJMKV>; Mon, 10 Dec 2001 07:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286240AbRLJMKB>; Mon, 10 Dec 2001 07:10:01 -0500
Received: from [195.66.192.167] ([195.66.192.167]:42758 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286237AbRLJMKA>; Mon, 10 Dec 2001 07:10:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] fully preemptible kernel
Date: Mon, 10 Dec 2001 14:08:03 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1007930466.11789.2.camel@phantasy> <1007967834.878.30.camel@phantasy> <01121010295102.01013@manta>
In-Reply-To: <01121010295102.01013@manta>
MIME-Version: 1.0
Message-Id: <01121014080300.09281@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I just installed 2.4.17pre7+preempt and it still shows the bug.
No oops yet (oops doesn't show up frequently).
2.4.17pre7 without preempt is being compiled right now.

> > > I reported a problem with preemptible 2.4.13 and Samba server (oops,
> > > problems with creation of files from win clients).
> > > Is this issue addressed?
> >
> > No, because I could not reproduce it.  Could you see if it occurs on the
> > current kernel with the current patch?  If so, send me the relevant
> > information.
...
...
> I have ksymoops compiled from sources and it does not work right
> ("Error (Oops_bfd_perror): set_section_contents Section has no contents").
> Can you enlighten me why I'm getting ths message?
> Or just send me working ksymoops binary, we can sort out this later.

In preparation for oops I need ksymoops binary. Mine is not ok:

> Unable to handle kernel paging request at virtual address 4008e6ed
> *pde = 01100067
> Oops: 0003
> CPU:    0
> EIP:    0010:[<c010655b>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: 4008e76d   ecx: 4008e6cd   edx: 0000e865
> esi: 00000000   edi: 00000128   ebp: 4008e6c9   esp: c1c5bf74
> ds: 0018   es: 0018   ss: 0018
> Process smbd (pid: 213, stackpage=c1c5b000)
> Stack: 5650faf0 c1c5a000 c029afd0 00000128 c01068d0 4008e6cd 4008e76d
> c1c5bf94 c02a23b2 55c3c85e ec83e589 4000bcd9 40015f67 4000bcd9 40015f67
> c1c5a000 00000000 00000000 bfffea74 c0107603 00000000 bfffe6a3 00000001
> 00000000 Call Trace: [<c01068d0>] [<c0107603>]
> Code: 89 51 20 31 c0 66 8b 53 0c 81 e2 ff ff 00 00 09 c6 89 51 1c
> Error (Oops_bfd_perror): set_section_contents Section has no contents
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Dunno is it a result of miscompiled ksymoops or what...
--
vda
