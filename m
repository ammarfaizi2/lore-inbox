Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVBIXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVBIXBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVBIXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 18:01:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:57306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261955AbVBIXBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 18:01:38 -0500
Date: Wed, 9 Feb 2005 15:06:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: anton@samba.org, ahuja@austin.ibm.com, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC64 collect and export low-level cpu usage statistics
Message-Id: <20050209150643.60812d3f.akpm@osdl.org>
In-Reply-To: <16906.34562.379000.336836@cargo.ozlabs.ibm.com>
References: <16906.34562.379000.336836@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> POWER5 machines have a per-hardware-thread register which counts at a
> rate which is proportional to the percentage of cycles on which the
> cpu dispatches an instruction for this thread (if the thread gets all
> the dispatch cycles it counts at the same rate as the timebase
> register).  This register is also context-switched by the hypervisor.
> Thus it gives a fine-grained measure of the actual cpu usage by the
> thread over time.
> 
> This patch adds code to read this register every timer interrupt and
> on every context switch.

fyi: This patch consumes another entry from thread_struct.pad[]. 
ppc64-implement-a-vdso-and-use-it-for-signal-trampoline.patch consumes two
more entries, so with both patches, you have none left.


