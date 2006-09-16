Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWIPKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWIPKpp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWIPKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 06:45:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49841 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751415AbWIPKpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 06:45:44 -0400
Message-ID: <450BD5F4.10302@sgi.com>
Date: Sat, 16 Sep 2006 12:46:12 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev <ltt-dev@shafik.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure)  0.5.108
References: <200609151316_MC3-1-CB57-4BE@compuserve.com>
In-Reply-To: <200609151316_MC3-1-CB57-4BE@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <1158331071.29932.63.camel@localhost.localdomain>
> 
> On Fri, 15 Sep 2006 15:37:51 +0100, Alan Cox wrote:
> 
>>> $ grep KPROBES arch/*/Kconf*
>>> arch/i386/Kconfig:config KPROBES
>>> arch/ia64/Kconfig:config KPROBES
>>> arch/powerpc/Kconfig:config KPROBES
>>> arch/sparc64/Kconfig:config KPROBES
>>> arch/x86_64/Kconfig:config KPROBES
>> Send patches. The fact nobody has them implemented on your platform
>> isn't a reason to implement something else, quite the reverse in fact.
> 
> Yes, but the point is: until that's done you can't claim kprobes is a
> valid tracing tool for everyone.

The fact that the remaining architectures haven't bothered implementing
kprobe supposed should not be used as an argument for pushing something
inferior out of laziness.

It's the same with syscalls, the kernel infrastructure is there, but if
you don't bother updating the syscall tables and wrap it in with glibc,
then the call isn't available on your architecture.

The core kprobe infrastructure is available to all architectures, it's
up to the developers of the remaining architectures to implement the
remaining bits.

Jes
