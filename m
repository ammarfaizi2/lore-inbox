Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbTGVMwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270815AbTGVMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:52:19 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:51681 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S270813AbTGVMwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:52:16 -0400
Date: Tue, 22 Jul 2003 15:07:18 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Deas, Jim" <James.Deas@warnerbros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc - kmalloc and page locks
Message-ID: <20030722130718.GB31455@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <S270817AbTGVMp3/20030722124529Z+5562@vger.kernel.org>
X-Operating-System: vega Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please read something about the mlock() and/or mlockall() functions.
The prototype can be found in [/usr/include/]sys/mman.h
You can read there:

/* Guarantee all whole pages mapped by the range [ADDR,ADDR+LEN) to
   be memory resident.  */
extern int mlock (__const void *__addr, size_t __len) __THROW;
[...]
/* Cause all currently mapped pages of the process to be memory resident
   until unlocked by a call to the `munlockall', until the process exits,
   or until the process calls `execve'.  */
extern int mlockall (int __flags) __THROW;

On Tue, Jul 22, 2003 at 06:00:14AM -0700, Deas, Jim wrote:
> How can I look at what memory are being paged out of memory in the kernel
> or how to lock kmalloc and vmalloc pages so they do not get put to swap?
[...]

- Gábor (larta'H)
