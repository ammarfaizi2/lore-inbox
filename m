Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbSJEPxS>; Sat, 5 Oct 2002 11:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbSJEPxS>; Sat, 5 Oct 2002 11:53:18 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:65277 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262389AbSJEPxN>; Sat, 5 Oct 2002 11:53:13 -0400
Subject: Re: 2.4.19 NFS file perms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trond.myklebust@fys.uio.no
Cc: Richard Zidlicky <rz@linux-m68k.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <15775.2654.502424.712655@charged.uio.no>
References: <20021005122115.A1338@linux-m68k.org> 
	<15775.2654.502424.712655@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 17:07:33 +0100
Message-Id: <1033834053.4103.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 16:50, Trond Myklebust wrote:
> >>>>> " " == Richard Zidlicky <rz@linux-m68k.org> writes:
> 
>      > Hi, on an NFS mounted fs, executing as root I see this:
> 
>      > read(4, 0xefffe4cb, 1) = -1 EIO (Input/output error)
> 
>      > glibc crashes in fgets because it doesn't expect the problem
>      > after the file has been successfully opened and mapped.. who is
>      > at fault here?
> 
> The 'soft' mount option perhaps?

If glibc crashes because of an unmap you are I suspect running a gcc 2.3
snapshot with the buggy and bogus mmap stdio option. If so turn it off
before it does any more harm.

