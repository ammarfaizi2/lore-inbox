Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290656AbSARKe2>; Fri, 18 Jan 2002 05:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290658AbSARKeT>; Fri, 18 Jan 2002 05:34:19 -0500
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:4889 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S290656AbSARKeG>; Fri, 18 Jan 2002 05:34:06 -0500
Message-ID: <3C47FA17.A0ACA25C@stud.uni-saarland.de>
Date: Fri, 18 Jan 2002 10:33:59 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-saarland.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: marko milovanovic <m.milo@ifrance.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.7 on a 7.2 redha
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hi everyone,
> we're running a 2.4.7-10smp kernel on a hp lh3000 server with 1gb ram scsi
> disks and 2 pentium iii cpus
>

Normal memory or ECC memory? It seems that a bit flip corrupted a data
structure.

> we have one a day a kernel panic  with this message :
> *********************************************
> Unable to handle kernel NULL pointer dereference at virtual address 0000000d
> [snip]
> Oops:
> eax: e6d9842c   ebx: daabf760   ecx: d763daa0   edx: 00000001
> [snip]
> Code;  c01f35ad <tcp_v4_get_port+14d/290>   <=====
>    0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====

%edx is 1, probably 0 would have been correct.

--
	Manfred
