Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbTDBTvo>; Wed, 2 Apr 2003 14:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbTDBTvo>; Wed, 2 Apr 2003 14:51:44 -0500
Received: from ns.suse.de ([213.95.15.193]:53253 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261680AbTDBTvo>;
	Wed, 2 Apr 2003 14:51:44 -0500
Subject: Re: [PATCH][2.4.21-pre6] update x86_64 for kernel_thread change
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16011.16021.699436.97176@gargle.gargle.HOWL>
References: <16011.14209.703212.772185@gargle.gargle.HOWL>
	<1049311995.10050.47.camel@averell> 
	<16011.16021.699436.97176@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Apr 2003 22:00:09 +0200
Message-Id: <1049313611.10051.72.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 21:48, mikpe@csd.uu.se wrote:
> Andi Kleen writes:
>  > On Wed, 2003-04-02 at 21:18, Mikael Pettersson wrote:
>  > > Building an x86_64 kernel from 2.4.21-pre6 results in two linkage
>  > > errors due to the recent kernel_thread to arch_kernel_thread name change.
>  > > This patch updates x86_64 for that change.
>  > 
>  > You need more changes to fix the ptrace hole completely.
> 
> More generic fixes or more x86_64-specific fixes?

x86-64 specific fixes. It was not calling the ptrace permission checking
functions correctly. Also the 32bit ptrace emulation had another
security hole.

See the changelog for arch/x86_64/kernel/ptrace.c and
arch/x86_64/ia32/ptrace32.c in x86-64.org CVS

-Andi


