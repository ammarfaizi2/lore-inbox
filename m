Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311032AbSCHTdk>; Fri, 8 Mar 2002 14:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311058AbSCHTda>; Fri, 8 Mar 2002 14:33:30 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:30622 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S311032AbSCHTdR>; Fri, 8 Mar 2002 14:33:17 -0500
Date: Fri, 8 Mar 2002 19:32:57 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Message-ID: <20020308193257.B18247@kushida.apsleyroad.org>
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <20020307153228.3A6773FE06@smtp.linux.ibm.com> <20020307104241.D24040@devserv.devel.redhat.com> <20020307191043.9C5F33FE15@smtp.linux.ibm.com> <a68htg$bc1$1@cesium.transmeta.com> <20020308172706.1e4d3f5e.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020308172706.1e4d3f5e.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Fri, Mar 08, 2002 at 05:27:06PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> One or more userspace processes share address space, so they can both do
> simple atomic operations on the same memory (hence the new PROT_SEM flag to
> mmap/mprotect for architectures which need to know).  They agree that "this
> address contains an integer which we use as a mutex" (aka. struct futex).

FWIW, there is a precedent from FreeBSD for a MAP_HASSEMAPHORE flag
meaning "this region may contain semaphores".

I don't know if that implies anything about the support of futex system
calls, but it may be the appropriate flag to indicate "atomic operations
are seen as such between processes on these pages".

-- Jamie
