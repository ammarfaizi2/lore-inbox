Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbSJLVPm>; Sat, 12 Oct 2002 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSJLVPm>; Sat, 12 Oct 2002 17:15:42 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49842 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261351AbSJLVPl>; Sat, 12 Oct 2002 17:15:41 -0400
Subject: Re: Performance improvement inquiry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zapp Foster <zzaappp@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021012202642.53345.qmail@web11908.mail.yahoo.com>
References: <20021012202642.53345.qmail@web11908.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 22:33:34 +0100
Message-Id: <1034458414.15067.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 21:26, Zapp Foster wrote:
> First question:  Will compiling a kernel with
> the network module resident (as opposed to a loadable
> module) make network performance any better?  From
> the reading, it appears that resident modules are only
> faster in initialization, not runtime.  I'm new to
> this, so please correct me if I'm wrong.

Modules are very very fractionally slower than compiled in code due to
TLB misses
 
> Second:  Threads.  Each server runs one to several
> custom services I've written, each of which performs a
> part of data processing on the incoming data.  Each
> service consists of eight to thirty threads.  The
> question:  Is there a way to tweak the kernel to
> improve thread performance?  I hear the 2.5 kernel 

Update to the RH 7.3 kernel and you will get the O(1) scheduler too

> how likely it is that shared libs (used either by my
> services or the kernel/OS) are being re-read from
> disk?  I am hoping that the libs get cached and thus
> load from cache back into memory.

They do


