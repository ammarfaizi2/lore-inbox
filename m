Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270825AbTGVM56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTGVM56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:57:58 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:18914 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S270825AbTGVM54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:57:56 -0400
Date: Tue, 22 Jul 2003 15:12:59 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Deas, Jim" <James.Deas@warnerbros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc - kmalloc and page locks
Message-ID: <20030722131259.GD31455@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org> <20030722130718.GB31455@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030722130718.GB31455@vega.digitel2002.hu>
X-Operating-System: vega Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Errrrr ... Sorry, I did not read your mail carefully ;-(
I meant in case of a user process you can use mlock() and such :)
AFAIK the kernel itself is not pagable ...

On Tue, Jul 22, 2003 at 03:07:18PM +0200, Gábor Lénárt wrote:
> Please read something about the mlock() and/or mlockall() functions.
> The prototype can be found in [/usr/include/]sys/mman.h
> You can read there:
> 
> /* Guarantee all whole pages mapped by the range [ADDR,ADDR+LEN) to
>    be memory resident.  */
> extern int mlock (__const void *__addr, size_t __len) __THROW;
> [...]
> /* Cause all currently mapped pages of the process to be memory resident
>    until unlocked by a call to the `munlockall', until the process exits,
>    or until the process calls `execve'.  */
> extern int mlockall (int __flags) __THROW;
> 
> On Tue, Jul 22, 2003 at 06:00:14AM -0700, Deas, Jim wrote:
> > How can I look at what memory are being paged out of memory in the kernel
> > or how to lock kmalloc and vmalloc pages so they do not get put to swap?
> [...]
> 
> - Gábor (larta'H)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- Gábor (larta'H)
