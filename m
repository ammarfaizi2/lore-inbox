Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJVWys>; Tue, 22 Oct 2002 18:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSJVWyr>; Tue, 22 Oct 2002 18:54:47 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31163 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262062AbSJVWyr>; Tue, 22 Oct 2002 18:54:47 -0400
Subject: Re: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <20021022224853.I27461@parcelfarce.linux.theplanet.co.uk>
References: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk>
	<1035323879.329.185.camel@irongate.swansea.linux.org.uk> 
	<20021022224853.I27461@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 00:17:12 +0100
Message-Id: <1035328632.329.187.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 22:48, Matthew Wilcox wrote:
> On Tue, Oct 22, 2002 at 10:57:59PM +0100, Alan Cox wrote:
> > On Tue, 2002-10-22 at 22:27, Matthew Wilcox wrote:
> > > 
> > > On PA-RISC we have 36 signals defined for hpux compatibility.  So M()
> > > and T() in kernel/signal.c try to do (1UL << 33) which is garbage on 32-bit
> > > architectures.  How do people feel about this patch?
> > 
> > How does the compiler output look ?
> 
> uhh.. 200 bytes extra on x86 ;-(
> 
> -rw-r--r--    1 willy    users       17956 Oct 22 14:44 kernel/signal.o
> -rw-r--r--    1 willy    users       17748 Oct 22 06:50 kernel/signal.o_orig

Care to move the define into include/asm-foo then ?

