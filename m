Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWGLVdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWGLVdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWGLVdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:33:22 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:1631 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751426AbWGLVdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:33:22 -0400
Message-ID: <44B56A99.2060402@tls.msk.ru>
Date: Thu, 13 Jul 2006 01:33:13 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	<44B54EA4.5060506@redhat.com>	<20060712195349.GW3823@sunsite.mff.cuni.cz>	<44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
[]
> Glibc just wants to know if our kernel is SMP so it can know if it is
> ok to busy wait for a bit waiting for a mutex.  Or if busy waiting is
> a complete loss.

BTW, with smp-alternatives thing merged, "SMP or not" may not be that
simple question anymore.

I for one stopped compiling UP and SMP kernels for x86 since 2.6.17,
because SMP kernel works just fine on UP, including benchmarks (as
opposed to SMP kernel w/o smp-alternatives).  But I don't remember
if uname shows SMP in this case or not (don't have any running UP
machine with that kernel right now).

But the thing is: smp-alternatives + cpu-hotplug changes things at
runtime...

/mjt
