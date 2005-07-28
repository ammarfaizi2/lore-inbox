Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVG1I2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVG1I2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVG1I2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:28:38 -0400
Received: from mail.portrix.net ([212.202.157.208]:64475 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261327AbVG1I13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:27:29 -0400
Message-ID: <42E896EC.7030503@ppp0.net>
Date: Thu, 28 Jul 2005 10:27:24 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050602 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net> <buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>
In-Reply-To: <buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> Jan Dittmer <jdittmer@ppp0.net> writes:
> 
>>Which is the recommended gcc/binutils combination for v850?
> 
> 
> The most crucial thing is that all supported processors are v850e
> derivatives (note the "e"), so please configure gcc/binutils for target
> "v850e-elf".

Thanks, that got me much further, compilation aborts now with

  CC      arch/v850/lib/negdi2.o
arch/v850/lib/negdi2.c: In function `__negdi2':
arch/v850/lib/negdi2.c:25: warning: control reaches end of non-void function
  AR      arch/v850/lib/lib.a
/bin/sh: +@: command not found
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
In file included from include/linux/hardirq.h:7,
                 from include/asm-generic/local.h:6,
                 from include/asm/local.h:4,
                 from include/linux/module.h:21,
                 from init/version.c:10:
include/asm/hardirq.h:21:27: warning: "NR_IRQS" is not defined
  LD      init/built-in.o
  LD      vmlinux
mm/built-in.o: In function `out_of_memory':
/usr/src/ctest/oo/kernel/mm/oom_kill.c:264: undefined reference to `show_mem'
/usr/src/ctest/oo/kernel/mm/oom_kill.c:264: relocation truncated to fit: R_V850_22_PCREL against undefined symbol `show_mem'
mm/built-in.o: In function `_alloc_pages':
/usr/src/ctest/oo/kernel/mm/page_alloc.c:1013: undefined reference to `show_mem'
/usr/src/ctest/oo/kernel/mm/page_alloc.c:1013: relocation truncated to fit: R_V850_22_PCREL against undefined symbol `show_mem'
fs/built-in.o: In function `smaps_open':
/usr/src/ctest/oo/kernel/fs/proc/base.c:600: undefined reference to `proc_pid_smaps_op'
make: *** [vmlinux] Error 1

Thanks,

-- 
Jan
