Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVHVW4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVHVW4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVHVW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:56:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9358 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751266AbVHVW4C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:02 -0400
Date: Sun, 21 Aug 2005 20:48:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Um9n6XJpbw==?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.13-rc6-mm1
Message-Id: <20050821204827.377d3d9d.akpm@osdl.org>
In-Reply-To: <20050822011528.GA12602@ime.usp.br>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<20050822011528.GA12602@ime.usp.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> Unfortunately, it seems that current kernels (including vanilla -rc
>  kernels) don't compile correctly on ppc if I have APM emulation enabled,
>  but PMU disabled (only CUDA enabled).
> 
>  Here is what I get from a compilation try:
> 
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>  debian:~/kernel/linux# make vmlinux
>    CHK     include/linux/version.h
>  make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>    CHK     include/linux/compile.h
>    CHK     usr/initramfs_list
>    CC      sound/oss/dmasound/dmasound_awacs.o
>  sound/oss/dmasound/dmasound_awacs.c:262: warning: 'struct pmu_sleep_notifier' declared inside parameter list
>  sound/oss/dmasound/dmasound_awacs.c:262: warning: its scope is only this definition or declaration, which is probably not what you want
>  sound/oss/dmasound/dmasound_awacs.c:263: error: variable 'awacs_sleep_notifier' has initializer but incomplete type
>  sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
>  sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for 'awacs_sleep_notifier')
>  sound/oss/dmasound/dmasound_awacs.c:264: error: 'SLEEP_LEVEL_SOUND' undeclared here (not in a function)
>  sound/oss/dmasound/dmasound_awacs.c:264: warning: excess elements in struct initializer
>  sound/oss/dmasound/dmasound_awacs.c:264: warning: (near initialization for 'awacs_sleep_notifier')
>  sound/oss/dmasound/dmasound_awacs.c:1424: error: conflicting types for 'awacs_sleep_notify'
>  sound/oss/dmasound/dmasound_awacs.c:262: error: previous declaration of 'awacs_sleep_notify' was here
>  sound/oss/dmasound/dmasound_awacs.c: In function 'awacs_sleep_notify':
>  sound/oss/dmasound/dmasound_awacs.c:1428: error: 'PBOOK_SLEEP_NOW' undeclared (first use in this function)

Could you send the .config please?
