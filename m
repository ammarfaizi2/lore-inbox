Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRABKMZ>; Tue, 2 Jan 2001 05:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbRABKMQ>; Tue, 2 Jan 2001 05:12:16 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:50185 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129826AbRABKMG>; Tue, 2 Jan 2001 05:12:06 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A51A1DB.74540C02@yahoo.com>
Date: Tue, 02 Jan 2001 04:39:39 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: start___kallsyms missing from i386 vmlinux.lds ?
In-Reply-To: <26475.978421415@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Tue, 02 Jan 2001 01:56:08 -0500,
> Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
> >--- linux/arch/i386/vmlinux.lds~       Fri Jul  7 03:47:07 2000
> >+++ linux/arch/i386/vmlinux.lds        Mon Jan  1 07:55:50 2001
> >+  __start___kallsyms = .;     /* All kernel symbols */
> >+  __kallsyms : { *(__kallsyms) }
> >+  __stop___kallsyms = .;
> 
> kernel/module.c defines
> extern const char __start___kallsyms[] __attribute__ ((weak));
> extern const char __stop___kallsyms[] __attribute__ ((weak));
> 
> The symbols are weak and do not need to be defined.  If gcc is not
> honouring __attribute__ ((weak)) then you have a broken or obsolete
> version of gcc.  You need at least gcc 2.91.66 for kernel 2.4.

Yep, saw the weak part - just noted while scanning test11 diff
that they were defined like the above patch for arch/sparc* and
wondered if the inconsistency was intentional.

Thanks,
Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
