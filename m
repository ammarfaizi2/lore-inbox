Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRL1Pl4>; Fri, 28 Dec 2001 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286927AbRL1Plr>; Fri, 28 Dec 2001 10:41:47 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:4252 "EHLO
	uni-koblenz.de") by vger.kernel.org with ESMTP id <S280971AbRL1Plj>;
	Fri, 28 Dec 2001 10:41:39 -0500
Date: Fri, 28 Dec 2001 13:41:06 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
        Amber Palekar <amber_palekar@yahoo.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Again:syscall from modules
Message-ID: <20011228134106.B1323@dea.linux-mips.net>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com> <1009468465.15846.0.camel@eggis1> <15403.28458.153083.961800@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15403.28458.153083.961800@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Dec 27, 2001 at 07:57:46PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 07:57:46PM +0100, Trond Myklebust wrote:

> You are scaremongering a bit here. Several of the sys_* functions
> *are* generic, and could be called by quite safely by the kernel. Look
> for instance at the use of sys_close() by the binfmt stuff.
> 
> Normally, though, there will be a price to pay in terms of an
> overhead.
> Furthermore, if you find that you absolutely *have* to use the sys_*
> interface, from userspace you will probably want to rethink your
> design: after all you can call all those sys_* functions from user
> space, and the rule of thumb is that if you *can* do something in user
> space, you ought to do it there...

Many sys_*() functions may be in the generic code but that still doesn't
mean the ports are actually using it or that no special calling sequence
which normally would be done in libc is required.  Only people doing
syscalls themselfes and not through libc wrappers is worse ...

  Ralf
