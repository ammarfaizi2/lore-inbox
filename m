Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUBHMNR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 07:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUBHMNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 07:13:17 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:12220 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S263526AbUBHMNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 07:13:15 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2004 12:13:13 -0000
MIME-Version: 1.0
Subject: Re[3]: 2.6.2 Compile Failure - Redhat 7.3 Distro
Message-ID: <402627D9.21481.19D612E6@localhost>
In-reply-to: <1075729900.777.40.camel@bart>
References: <1075370497.775.89.camel@bart>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Robert,
>
>   Sighs...I guess I have to look at making new set of RPM packages 
> for 7.3 Distros \
> to upgrade the glibc, gcc and few other packages to have it updated 
> to be able to \
> compile the kernel.
>
>  Thanks.

Saturday, February 7, 2004, 4:31:25 PM, you wrote:

RFM> Elikster wrote:

> > fs/proc/array.c: In function `proc_pid_stat':
> > fs/proc/array.c:398: Unrecognizable insn:
> > (insn/i 721 1009 1003 (parallel[
> > (set (reg:SI 0 eax)
> > (asm_operands ("") ("=a") 0[
> > (reg:DI 1 edx)
> > ]
> > [
> > (asm_input:DI ("A"))
> > ]  ("include/linux/times.h") 38))
> > (set (reg:SI 1 edx)
> > (asm_operands ("") ("=d") 1[
> > (reg:DI 1 edx)
> > ]
> > [
> > (asm_input:DI ("A"))
> > ]  ("include/linux/times.h") 38))
> > (clobber (reg:QI 19 dirflag))
> > (clobber (reg:QI 18 fpsr))
> > (clobber (reg:QI 17 flags))
> > ] ) -1 (insn_list 715 (nil))
> > (nil))
> > fs/proc/array.c:398: confused by earlier errors, bailing out
> > make[2]: *** [fs/proc/array.o] Error 1
> > make[1]: *** [fs/proc] Error 2
> > make: *** [fs] Error 2
> > root@longmont [/usr/src/linux-2.6.2]#

I was getting all sorts of funny reportedly code errors with RH GCC:

gcc version 2.96 20000731 (Red Hat Linux 7.2 2.96-112.7.1)

It used to build ok, then report an error somewhere.. but never in 
the same place/file.  Funnily enough, a kernel built with 5 or 6 of 
these errors (i.e. just 'make'ing again from where it 'broke' to 
carry on the build) is OK.

Well, for me it turned out GCC gets very _flakey_ if CPU (K6 233) 
gets too hot...

...I just put on a bigger heatsink, and it fixed it!

The machine had/has never shown any other symptoms of overheating 
until/unless I build a kernel.

Nick 
