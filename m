Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWGIUi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWGIUi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWGIUi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:38:59 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:51653 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161131AbWGIUi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:38:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Gregoire Favre <gregoire.favre@gmail.com>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Date: Sun, 9 Jul 2006 22:39:48 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709114925.GA9009@gmail.com>
In-Reply-To: <20060709114925.GA9009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607092239.48065.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 13:49, Gregoire Favre wrote:
> Hello,
> 
> can't compil it :
> 
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o: In function `vsyscall_set_cpu':
> (.init.text+0x1e87): undefined reference to `smp_call_function_single'
> make: *** [.tmp_vmlinux1] Error 1

This is because of x86_64-mm-getcpu-vsyscall.patch which breaks
compilation without SMP and is not obviously fixable.

I think you can safely revert it.

Greetings,
Rafael
