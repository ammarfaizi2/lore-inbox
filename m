Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbSJVVmp>; Tue, 22 Oct 2002 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbSJVVmp>; Tue, 22 Oct 2002 17:42:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57361 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264813AbSJVVmp>;
	Tue, 22 Oct 2002 17:42:45 -0400
Date: Tue, 22 Oct 2002 22:48:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
Subject: Re: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
Message-ID: <20021022224853.I27461@parcelfarce.linux.theplanet.co.uk>
References: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk> <1035323879.329.185.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035323879.329.185.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 22, 2002 at 10:57:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 10:57:59PM +0100, Alan Cox wrote:
> On Tue, 2002-10-22 at 22:27, Matthew Wilcox wrote:
> > 
> > On PA-RISC we have 36 signals defined for hpux compatibility.  So M()
> > and T() in kernel/signal.c try to do (1UL << 33) which is garbage on 32-bit
> > architectures.  How do people feel about this patch?
> 
> How does the compiler output look ?

uhh.. 200 bytes extra on x86 ;-(

-rw-r--r--    1 willy    users       17956 Oct 22 14:44 kernel/signal.o
-rw-r--r--    1 willy    users       17748 Oct 22 06:50 kernel/signal.o_orig

-- 
Revolutions do not require corporate support.
