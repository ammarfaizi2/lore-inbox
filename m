Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJTM45>; Sat, 20 Oct 2001 08:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRJTM4r>; Sat, 20 Oct 2001 08:56:47 -0400
Received: from mailrelay1.inwind.it ([212.141.54.101]:9608 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S273204AbRJTM4b>; Sat, 20 Oct 2001 08:56:31 -0400
Message-Id: <3.0.6.32.20011020145906.01f60a00@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sat, 20 Oct 2001 14:59:06 +0200
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: [PATCH] updated preempt-kernel
In-Reply-To: <1003562833.862.65.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03.27 20/10/01 -0400, Robert Love wrote:
>Testers Wanted:
>
>patches to enable a fully preemptible kernel are available at:
>	http://tech9.net/rml/linux
>for kernels 2.4.10, 2.4.12, 2.4.12-ac3, and 2.4.13-pre5.
>
>What is this:
>
>A preemptible kernel.  It lowers your latency.
>
>What is New:
>
>* sync with new kernel releases
>
>* if HIGHMEM_DEBUG was on the preempt counter would be incremented at
>times but never decremented.  this resulted in preemption becoming
>permanently disabled.
>
>* if HIGHMEM_DEBUG was not on, HIGHMEM would crash the system horribly
>due to a case where preemption was enabled without a corresponding
>disable.
>
>* reapply dropped hunk to pgalloc to prevent reentrancy onto per-CPU
>data

This above seems to have fixed some spontaneous reboots and oopses
I experiencied with 2.4.11 and 2.4.12-1 preempt-kernel patches.

>The next few patches are going to work on identifying any remaining
>per-CPU variables that need explicit locking under preemption.
>
>	Robert Love



-- 
Lorenzo
