Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJJLG2>; Thu, 10 Oct 2002 07:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJJLG2>; Thu, 10 Oct 2002 07:06:28 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51114 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262841AbSJJLG2>; Thu, 10 Oct 2002 07:06:28 -0400
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
Cc: colpatch@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, LSE <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
In-Reply-To: <1034244381.3629.8.camel@localhost.localdomain>
References: <3DA4D3E4.6080401@us.ibm.com> 
	<1034244381.3629.8.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 12:22:51 +0100
Message-Id: <1034248971.2044.118.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 11:06, Arjan van de Ven wrote:
> 
> > +/**
> > + * sys_mem_setbinding - set the memory binding of a process
> > + * @pid: pid of the process
> > + * @memblks: new bitmask of memory blocks
> > + * @behavior: new behavior
> > + */
> > +asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks, 
> > +				    unsigned int behavior)
> > +{
> 
> Do you really think exposing low level internals as memory layout / zone
> split up to userspace is a good idea ? (and worth it given that the VM
> already has a cpu locality preference?)

At least in the embedded world that level is a good idea. I'm not sure
about the syscall interface. An "unsigned long" mask of blocks sounds
like a good way to ensure a broken syscall in the future

