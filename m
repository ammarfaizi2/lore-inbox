Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318374AbSGaNx5>; Wed, 31 Jul 2002 09:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318375AbSGaNx5>; Wed, 31 Jul 2002 09:53:57 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:8145 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S318374AbSGaNx4>; Wed, 31 Jul 2002 09:53:56 -0400
From: "David Luyer" <david@luyer.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 23:57:09 +1000
Message-ID: <00d101c2389a$29995970$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <1028127891.8510.79.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Possibly because show_cpuinfo() in arch/i386/kernel/setup.c prints
> > directly out of phys_proc_id as at the time it's called, but
> > smpboot.c declates phys_proc_id as __initdata (either that, or
> > phys_proc_id is actually zero for both CPUs?).
> 
> The former is the problem. Thanks for spotting it. As to the text
> string, I'll have a chat with Ulrich about it and see what he thinks

The former and the latter possibly: the only assignment I see for
phys_proc_id is when hyperthreading is happening (in fact, requires
all of X86_FEATURE_HT, !disable_x86_ht and smp_num_siblings > 1);
down the end of kernel/setup.c init_intel().

David.

