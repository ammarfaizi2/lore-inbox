Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVAZBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVAZBIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAZBGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:06:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1730 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262158AbVAZBFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:05:48 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050124080254.GA7753@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu>
	 <200501221622.24273.gene.heskett@verizon.net>
	 <20050124080254.GA7753@elte.hu>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 20:05:42 -0500
Message-Id: <1106701543.3103.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 09:02 +0100, Ingo Molnar wrote:
> indeed - !PREEMPT_RT compilation broke. I've uploaded -03 with the fix
> (and other fixes).

-03 still does not compile with CONFIG_PREEMPT_DESKTOP:

rlrevell@mindpipe:~/kernel-source/linux-2.6.11-rc2$ make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      net/core/rtnetlink.o
net/core/rtnetlink.c: In function `rtnl_lock_interruptible':
net/core/rtnetlink.c:63: warning: implicit declaration of function `down_write_interruptible'
  LD      net/core/built-in.o
  LD      net/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o(.text+0x10f99): In function `rtnl_lock_interruptible':
net/core/rtnetlink.c:63: undefined reference to `down_write_interruptible'
make: *** [.tmp_vmlinux1] Error 1

Lee

