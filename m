Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUJSEPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUJSEPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUJSEPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 00:15:33 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:59512 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267926AbUJSEPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 00:15:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Weird... 2.6.9 kills FC2 gcc
Date: Mon, 18 Oct 2004 23:15:27 -0500
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Haverkamp <markh@osdl.org>
References: <4174697B.90306@pobox.com> <41747A28.2000101@pobox.com> <41748A9D.2080306@pobox.com>
In-Reply-To: <41748A9D.2080306@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410182315.27807.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 10:31 pm, Jeff Garzik wrote:
> 
> More data points:
> 
> No problems at all on x86-64.
> 
> No ICE on 32-bit x86 gcc 3.4.2, with 2.6.9 release kernel.
> 
> So this ICE appears to be a bug specific to 3.3.x or perhaps Fedora.
> 
> 	Jeff
> 

For what it worth this is on mutated RH 8.0:

[dtor@core dtor]$ make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  AS      arch/i386/kernel/vsyscall.o
include/linux/compiler.h:20: warning: parameter name starts with a digit in #define
include/linux/compiler.h:20: badly punctuated parameter list in #define
make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
make: *** [arch/i386/kernel] Error 2
[dtor@core dtor]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)


-- 
Dmitry
